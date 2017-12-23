# Reader Helper
# =============
#
# Utilities to generate file readers in BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module ReaderHelper

import Automa
import TranscodingStreams

"""
    @mark

Mark the current position to keep the buffered data.
"""
macro mark()
    esc(:(buffer.markpos = p))
end

"""
    @unmark

Unmark the buffer.
"""
macro unmark()
    esc(:(buffer.markpos = 0))
end

"""
    @pos

Get the current position relative to the marked position.
"""
macro pos()
    esc(:(p - buffer.markpos + 1))
end

function readrecord! end

"""
    generate_readrecord_function(rectype, machine, actions, initcode, exitcode, kwargs...)

Generate a `readrecord!(stream::TranscodingStream, record::rectype, state)` function.

`readrecord!` will parse data from `stream` and fill `record` as output. `state`
can be used to keep track of the parsing state. This function is for package
developers. See the source code for the exact behavior of `readrecord!`.

`RecordIterator` and `RecordIteratorState` defined in `BioCore.ReaderHelper` are
useful to generate parsers.

To extend the `readrecord!` function, it is required to import the function from
`BioCore.ReaderHelper`.

Arguments
---------
- `rectype`:
    Record type.
- `machine`:
    Automa's machine.
- `actions`:
    Actions associated with `machine`.
- `initcode`:
    Initial code that will be executed before the first parsing loop.
- `exitcode`:
    Exit code that will be executed after each parsing loop.
- `kwargs`:
    Keyword arguments passed to `Automa.CodeGenContext` (`generator`,
    `checkbounds`, `loopunroll`).
"""
function generate_readrecord_function(rectype::DataType,
                                      machine::Automa.Machine,
                                      actions::Dict{Symbol,Expr},
                                      initcode::Expr,
                                      exitcode::Expr;
                                      kwargs...)
    kwargs = Dict(kwargs)
    context = Automa.CodeGenContext(
        generator=get(kwargs, :generator, :goto),
        checkbounds=get(kwargs, :checkbounds, false),
        loopunroll=get(kwargs, :loopunroll, 0),
    )
    quote
        function readrecord!(
                stream::$(TranscodingStreams.TranscodingStream),
                record::$(rectype), state)
            @assert !ismarked(stream)

            # Initialize variables.
            buffer = stream.state.buffer1
            data = buffer.data
            $(Automa.generate_init_code(context, machine))
            $(initcode)

            # Start parsing.
            while true
                let eof = eof(stream)  # `eof` refills the buffer
                    p = buffer.bufferpos
                    p_end = buffer.marginpos - 1
                    if eof
                        p_eof = p_end
                    end
                end
                #print("before: "); @show cs, p, p_end, p_eof
                # The data buffer must not be moved within the generated code below!
                $(Automa.generate_exec_code(context, machine, actions))
                #print(" after: "); @show cs, p, p_end, p_eof

                # Restore consistency.
                let
                    markpos = buffer.markpos
                    skip(stream, p - buffer.bufferpos)
                    shift = markpos - buffer.markpos
                    @assert shift ≥ 0
                    p -= shift
                    p_end -= shift
                    if p_eof ≥ 0
                        p_eof -= shift
                    end
                end

                # Exit or repeat.
                $(exitcode)
            end
        end
    end
end

# Iterator of records.
struct RecordIterator{T}
    # input stream
    stream::TranscodingStreams.TranscodingStream

    # return a copy?
    copy::Bool

    # close stream at the end?
    close::Bool

    # placeholder of record
    record::T

    function RecordIterator{T}(stream::IO; copy::Bool=true, close::Bool=false) where T
        if !(stream isa TranscodingStreams.TranscodingStream)
            stream = TranscodingStreams.NoopStream(stream)
        end
        return new(stream, copy, close, T())
    end
end

function Base.iteratorsize(::Type{<:RecordIterator})
    return Base.SizeUnknown()
end

function Base.eltype(::Type{RecordIterator{T}}) where T
    return T
end

function Base.show(io::IO, iter::RecordIterator)
    print(io, summary(iter), "(<copy=$(iter.copy),close=$(iter.close)>)")
end

# State of RecordIterator.
mutable struct RecordIteratorState
    # the current line number
    linenum::Int

    # read a new record?
    read::Bool

    # consumed all input?
    done::Bool

    function RecordIteratorState()
        return new(1, false, false)
    end
end

function Base.start(iter::RecordIterator)
    return RecordIteratorState()
end

function Base.done(iter::RecordIterator, state::RecordIteratorState)
    if state.done
        return true
    elseif !state.read
        readrecord!(iter.stream, iter.record, state)
        if iter.close && state.done
            close(iter.stream)
        end
    end
    return !state.read
end

function Base.next(iter::RecordIterator, state::RecordIteratorState)
    @assert state.read
    record = iter.record
    if iter.copy
        record = copy(record)
    end
    state.read = false
    return record, state
end

# NOTE:
# The code below are deprecated and will be removed in the future. These
# tools will be replaced with tools based on TranscodingStreams.jl.
import BufferedStreams

@inline function anchor!(stream::BufferedStreams.BufferedInputStream, p, immobilize=true)
    stream.anchor = p
    stream.immobilized = immobilize
    return stream
end

@inline function upanchor!(stream::BufferedStreams.BufferedInputStream)
    @assert stream.anchor != 0 "upanchor! called with no anchor set"
    anchor = stream.anchor
    stream.anchor = 0
    stream.immobilized = false
    return anchor
end

function ensure_margin!(stream::BufferedStreams.BufferedInputStream)
    if stream.position * 20 > length(stream.buffer) * 19
        BufferedStreams.shiftdata!(stream)
    end
    return nothing
end

@inline function resize_and_copy!(dst::Vector{UInt8}, src::Vector{UInt8}, r::UnitRange{Int})
    return resize_and_copy!(dst, 1, src, r)
end

@inline function resize_and_copy!(dst::Vector{UInt8}, dstart::Int, src::Vector{UInt8}, r::UnitRange{Int})
    rlen = length(r)
    if length(dst) != dstart + rlen - 1
        resize!(dst, dstart + rlen - 1)
    end
    copy!(dst, dstart, src, first(r), rlen)
    return dst
end

@inline function append_from_anchor!(dst::Vector{UInt8}, dstart::Int, stream::BufferedStreams.BufferedInputStream, p::Int)
    return resize_and_copy!(dst, dstart, stream.buffer, upanchor!(stream):p)
end

function generate_index_function(record_type, machine, init_code, actions; kwargs...)
    kwargs = Dict(kwargs)
    context = Automa.CodeGenContext(
        generator=get(kwargs, :generator, :goto),
        checkbounds=get(kwargs, :checkbounds, false),
        loopunroll=get(kwargs, :loopunroll, 0)
    )
    quote
        function index!(record::$(record_type))
            data = record.data
            p = 1
            p_end = p_eof = sizeof(data)
            initialize!(record)
            $(init_code)
            cs = $(machine.start_state)
            $(Automa.generate_exec_code(context, machine, actions))
            if cs != 0
                throw(ArgumentError(string("failed to index ", $(record_type), " ~>", repr(String(data[p:min(p+7,p_end)])))))
            end
            @assert isfilled(record)
            return record
        end
    end
end

function generate_readheader_function(reader_type, metainfo_type, machine, init_code, actions, finish_code=:())
    quote
        function readheader!(reader::$(reader_type))
            _readheader!(reader, reader.state)
        end

        function _readheader!(reader::$(reader_type), state::BioCore.Ragel.State)
            stream = state.stream
            BioCore.ReaderHelper.ensure_margin!(stream)
            cs = state.cs
            linenum = state.linenum
            data = stream.buffer
            p = stream.position
            p_end = stream.available
            p_eof = -1
            finish_header = false
            record = $(metainfo_type)()

            $(init_code)

            while true
                $(Automa.generate_exec_code(Automa.CodeGenContext(generator=:table), machine, actions))

                state.cs = cs
                state.finished = cs == 0
                state.linenum = linenum
                stream.position = p

                if cs < 0
                    error("$($(reader_type)) file format error on line ", linenum)
                elseif finish_header
                    $(finish_code)
                    break
                elseif p > p_eof ≥ 0
                    error("incomplete $($(reader_type)) input on line ", linenum)
                else
                    hits_eof = BufferedStreams.fillbuffer!(stream) == 0
                    p = stream.position
                    p_end = stream.available
                    if hits_eof
                        p_eof = p_end
                    end
                end
            end
        end
    end
end

function generate_read_function(reader_type, machine, init_code, actions; kwargs...)
    kwargs = Dict(kwargs)
    context = Automa.CodeGenContext(
        generator=get(kwargs, :generator, :goto),
        checkbounds=get(kwargs, :checkbounds, false),
        loopunroll=get(kwargs, :loopunroll, 0)
    )
    quote
        function Base.read!(reader::$(reader_type), record::eltype($(reader_type)))::eltype($(reader_type))
            return _read!(reader, reader.state, record)
        end

        function _read!(reader::$(reader_type), state::BioCore.Ragel.State, record::eltype($(reader_type)))
            stream = state.stream
            BioCore.ReaderHelper.ensure_margin!(stream)
            cs = state.cs
            linenum = state.linenum
            data = stream.buffer
            p = stream.position
            p_end = stream.available
            p_eof = -1
            found_record = false
            initialize!(record)

            $(init_code)

            if state.finished
                throw(EOFError())
            end

            while true
                $(Automa.generate_exec_code(context, machine, actions))

                state.cs = cs
                state.finished |= cs == 0
                state.linenum = linenum
                stream.position = p

                if cs < 0
                    error($(reader_type), " file format error on line ", linenum, " ~>", repr(String(data[p:min(p+7,p_end)])))
                elseif found_record
                    break
                elseif cs == 0
                    throw(EOFError())
                elseif p > p_eof ≥ 0
                    error("incomplete $($(reader_type)) input on line ", linenum)
                elseif BufferedStreams.available_bytes(stream) < 64
                    hits_eof = BufferedStreams.fillbuffer!(stream) == 0
                    p = stream.position
                    p_end = stream.available
                    if hits_eof
                        p_eof = p_end
                    end
                end
            end

            @assert isfilled(record)
            return record
        end
    end
end

end

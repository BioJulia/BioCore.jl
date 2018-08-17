# BioCore.IO
# ======
#
# I/O interfaces for BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module IO

"""
Abstract file format type.

See `subtypes(FileFormat)` for all available file formats.
"""
abstract type FileFormat end

"""
Abstract formatted input/output type.
"""
abstract type AbstractFormattedIO end

"""
    stream(io::AbstractFormattedIO)

Return the underlying `IO` object; subtypes of `AbstractFormattedIO` must
implement this method.
"""
function stream end

# delegate method call
for f in (:eof, :flush, :close)
    @eval function Base.$(f)(io::AbstractFormattedIO)
        return $(f)(stream(io))
    end
end

function Base.open(f::Function, ::Type{T}, args...; kwargs...) where T <: AbstractFormattedIO
    io = open(T, args...; kwargs...)
    try
        f(io)
    finally
        close(io)
    end
end

"""
Abstract data reader type.

See `subtypes(AbstractReader)` for all available data readers.
"""
abstract type AbstractReader <: AbstractFormattedIO end

Base.IteratorSize(::Type{T}) where T <: AbstractReader = Base.SizeUnknown()

function Base.open(::Type{T}, filepath::AbstractString, args...; kwargs...) where T <: AbstractReader
    return T(open(filepath), args...; kwargs...)
end

function Base.read(input::AbstractReader)
    return read!(input, eltype(input)())
end

"""
    tryread!(reader::AbstractReader, output)

Try to read the next element into `output` from `reader`.

If the result could not be read, then `nothing` will be returned instead.
"""
function tryread!(reader::AbstractReader, output)
    try
        read!(reader, output)
        return output
    catch ex
        if isa(ex, EOFError)
            return nothing
        end
        rethrow()
    end
end

function Base.iterate(reader::AbstractReader, nextone = eltype(reader)())
    if tryread!(reader, nextone) === nothing
        return nothing
    else
        return copy(nextone), nextone
    end
end


"""
Abstract data writer type.

See `subtypes(AbstractWriter)` for all available data writers.
"""
abstract type AbstractWriter <: AbstractFormattedIO end

function Base.open(::Type{T}, filepath::AbstractString, args...; kwargs_...) where T <: AbstractWriter
    kwargs = collect(kwargs_)
    i = findfirst(kwarg -> kwarg[1] == :append, kwargs)
    if i !== nothing
        append = kwargs[i][2]
        if !isa(append, Bool)
            throw(ArgumentError("append must be boolean"))
        end
        deleteat!(kwargs, i)
    else
        append = false
    end
    return T(open(filepath, append ? "a" : "w"), args...; kwargs...)
end

end  # module BioCore.IO

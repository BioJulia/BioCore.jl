import Automa
import Automa.RegExp: @re_str
import BioCore.IO: eachrecord
import BioCore.ReaderHelper: @pos, @mark, @unmark, readrecord!

# Test a three-column TSV file format.

mutable struct Record
    data::Vector{UInt8}
    filled::Bool
    fields::Vector{UnitRange{Int}}

    Record() = new(UInt8[], false, UnitRange{Int}[])
    Base.copy(record::Record) = new(copy(record.data), record.filled, copy(record.fields))
end

function init!(record::Record)
    empty!(record.data)
    record.filled = false
    empty!(record.fields)
end

let
    machine = (function ()
        cat = Automa.RegExp.cat
        rep = Automa.RegExp.rep
        any = Automa.RegExp.any

        newline = re"\n"
        newline.actions[:enter] = [:newline]
        tab = re"\t"
        field = rep(any() \ tab \ newline)
        field.actions[:enter] = [:pos]
        field.actions[:exit]  = [:field]

        record = cat(field, tab, field, tab, field)
        record.actions[:enter] = [:mark]
        record.actions[:exit] = [:record]
        file = rep(cat(record, newline))

        Automa.compile(file)
    end)()

    initcode = quote
        init!(record)
        pos = 0
    end
    exitcode = quote
        if cs < 0
            throw(ArgumentError("unexpected data at line $(state.linenum)"))
        else
            state.done = cs == 0
            if !state.done && p > p_eof ≥ 0
                throw(ArgumentError("unexpected end of input"))
            end
            if state.read
                append!(record.data, buffer.data[buffer.markpos:p-2])
            end
            if state.read || state.done
                @unmark
                return
            end
        end
    end
    actions = Dict(
        :newline => :(state.linenum += 1),
        :pos     => :(pos = @pos),
        :mark    => :(@mark),
        :field   => :(push!(record.fields, pos:(@pos)-1)),
        :record  => :(state.read = true; @escape),
    )

    eval(BioCore.ReaderHelper.generate_readrecord_function(Record, machine, actions, initcode, exitcode))
end

struct Reader
    input::IO
end

function BioCore.IO.eachrecord(reader::Reader; copy::Bool=true)
    return BioCore.ReaderHelper.RecordIterator{Record}(reader.input; copy=copy)
end

@testset "ReaderHelper" begin
    input = IOBuffer("""
    foo\tbar\tbaz
    1\t2\t3
    3.1\t3.14\t3.1415
    """)
    records = collect(eachrecord(Reader(input)))
    @test length(records) == 3
    @test records[1].data == b"foo\tbar\tbaz"
    @test [records[1].data[r] for r in records[1].fields] == [b"foo", b"bar", b"baz"]
    @test records[2].data == b"1\t2\t3"
    @test [records[2].data[r] for r in records[2].fields] == [b"1", b"2", b"3"]
    @test records[3].data == b"3.1\t3.14\t3.1415"
    @test [records[3].data[r] for r in records[3].fields] == [b"3.1", b"3.14", b"3.1415"]

    # malformed input
    input = IOBuffer("""
    foo\tbar\tbaz
    1\t2
    """)
    @test_throws ArgumentError collect(eachrecord(Reader(input)))

    # truncated input
    input = IOBuffer("""
    foo\tbar\tbaz
    1\t2\t3""")
    @test_throws ArgumentError collect(eachrecord(Reader(input)))
end

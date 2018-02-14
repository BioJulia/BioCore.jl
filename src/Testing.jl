# Testing
# =======
#
# Utilities to assist testing of BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module Testing

const FMT_SPECIMEN_PATH = joinpath(dirname(dirname(@__FILE__)), "BioFmtSpecimens")

"""
    get_bio_fmt_specimens(checkout = "master", auto_checkout = true, fresh = false)

Install/update and return the path of BioJulia's biological data format
specimen archive.

When the BioFmtSpecimens archive is fetched from the web, the branch or tag
specified by  `checkout` is checked out for use. Unless, `auto_checkout` is
true, in which case, the latest tagged release of the BioFmtSpecimens archive
will be checked out.

If `fresh` is set to true, this will force a deletion of any currently installed
BioFmtSpecimens archive repository, and fetch it from the web again. This may
be useful if updating the installed BioFmtSpecimens archive is problematic.
"""
function get_bio_fmt_specimens(checkout = "master", auto_checkout = true, fresh = false)
    if fresh
        rm(FMT_SPECIMEN_PATH, force = true, recursive = true)
    end
    if !isdir(FMT_SPECIMEN_PATH)
        run(`git clone https://github.com/BioJulia/BioFmtSpecimens.git $(FMT_SPECIMEN_PATH)`)
    end
    cd(FMT_SPECIMEN_PATH) do
        if auto_checkout
            (so, si, pr) = readandwrite(`git describe --tags`)
            checkout = readline(so)
        end
        run(`git fetch origin`)
        run(`git checkout $(checkout)`)
    end
    return FMT_SPECIMEN_PATH
end

function bio_fmt_specimens(format::String, fn::Function, checkout = "master", auto_checkout = true, fresh = false)
    get_bio_fmt_specimens(checkout, auto_checkout, fresh)
    specimens = YAML.load_file(joinpath(FMT_SPECIMEN_PATH, format, "index.yml"))
    output = Vector{String}(length(specimens))
    oi = 0
    for specimen in specimens
        if fn(specimen)
            oi += 1
            output[oi] = joinpath(FMT_SPECIMEN_PATH, specimen["filename"])
        end
    end
    resize!(specimens, oi)
end

function random_array(n::Integer, elements, probs)
    cumprobs = cumsum(probs)
    x = Vector{eltype(elements)}(n)
    for i in 1:n
        x[i] = elements[searchsorted(cumprobs, rand()).start]
    end
    return x
end

function random_seq(n::Integer, nts, probs)
    cumprobs = cumsum(probs)
    x = Vector{Char}(n)
    for i in 1:n
        x[i] = nts[searchsorted(cumprobs, rand()).start]
    end
    return convert(String, x)
end

function random_dna(n, probs=[0.24, 0.24, 0.24, 0.24, 0.04])
    return random_seq(n, ['A', 'C', 'G', 'T', 'N'], probs)
end

function random_rna(n, probs=[0.24, 0.24, 0.24, 0.24, 0.04])
    return random_seq(n, ['A', 'C', 'G', 'U', 'N'], probs)
end

function random_aa(len)
    return random_seq(len,
        ['A', 'R', 'N', 'D', 'C', 'Q', 'E', 'G', 'H', 'I',
         'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V', 'X' ],
        push!(fill(0.049, 20), 0.02))
end

function intempdir(fn::Function, parent=tempdir())
    dirname = mktempdir(parent)
    try
        cd(fn, dirname)
    finally
        rm(dirname, recursive=true)
    end
end

function random_interval(minstart, maxstop)
    start = rand(minstart:maxstop)
    return start:rand(start:maxstop)
end

end # Module Testing

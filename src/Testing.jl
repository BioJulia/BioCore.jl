# Testing
# =======
#
# Utilities to assist testing of BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module Testing

import YAML

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
            checkout = open(readline, `git describe --tags`, "r+")
        end
        run(`git fetch origin`)
        run(`git checkout $(checkout)`)
    end
    return FMT_SPECIMEN_PATH
end

"""
    bio_fmt_specimens(format::String, fn::Function, checkout = "master", auto_checkout = true, fresh = false)

Get the paths for file format specimen files from BioJulia's biological data
format specimen archive.

Will return a vector of paths for specimen files of a given `format` (e.g. FASTA)
which satisfy the filter `fn`. the input for `fn` should be a single argument,
which is a `Dict{Any, Any}`. Each `Dict{Any, Any}` represents a format file
specimen from BioJulia's biological data format specimen archive, and has the
following fields:

* **"filename"**: Specimen filename.
* **"valid"**: `true` or `false`, indicates whether the example conforms to the format.
* **"origin"** The contributor or source from which a specimen was taken.
* **"tags"** Zero or more words used to group specimens by shared features.
* **"comments"** (Optional) Any additional information that might be of interest.

When the BioFmtSpecimens archive is fetched from the web or updated, the branch or tag
specified by  `checkout` is checked out for use. Unless, `auto_checkout` is
true, in which case, the latest tagged release of the BioFmtSpecimens archive
will be checked out.

If `fresh` is set to true, this will force a deletion of any currently installed
BioFmtSpecimens archive repository, and fetch it from the web again. This may
be useful if updating the installed BioFmtSpecimens archive is problematic.

```@example
# Get paths for FASTA format specimens which are examples of a valid file.
bio_fmt_specimens("FASTA", (x) -> x["valid"] == true)
```
"""
function bio_fmt_specimens(format::String, fn::Function, checkout = "master", auto_checkout = true, fresh = false)
    get_bio_fmt_specimens(checkout, auto_checkout, fresh)
    specimens = YAML.load_file(joinpath(FMT_SPECIMEN_PATH, format, "index.yml"))
    filtered_specimens = Vector{String}(undef, length(specimens))
    fsi = 0
    for specimen in specimens
        if fn(specimen)
            fsi += 1
            filtered_specimens[fsi] = joinpath(FMT_SPECIMEN_PATH, format, specimen["filename"])
        end
    end
    resize!(filtered_specimens, fsi)
    return filtered_specimens
end

function random_array(n::Integer, elements, probs)
    cumprobs = cumsum(probs)
    x = Vector{eltype(elements)}(undef, n)
    for i in 1:n
        x[i] = elements[searchsorted(cumprobs, rand()).start]
    end
    return x
end

function random_seq(n::Integer, nts, probs)
    cumprobs = cumsum(probs)
    x = Vector{Char}(undef, n)
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

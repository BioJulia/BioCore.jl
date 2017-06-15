module Testing

function get_bio_fmt_specimens()
    path = joinpath(dirname(dirname(@__FILE__)), "BioFmtSpecimens")
    if !isdir(path)
        run(`git clone --depth 1 https://github.com/BioJulia/BioFmtSpecimens.git $(path)`)
    end
end

function get_bio_fmt_index(format)
    path = joinpath(dirname(dirname(@__FILE__)), "BioFmtSpecimens", format)
    return YAML.load_file(path)
end

function random_array(n::Integer, elements, probs)
    cumprobs = cumsum(probs)
    x = Vector{eltype(elements)}(n)
    for i in 1:n
        x[i] = elements[searchsorted(cumprobs, rand()).start]
    end
    return x
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

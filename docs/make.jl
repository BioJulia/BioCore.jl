using Documenter, BioCore

makedocs(
    format = :html,
    sitename = "BioCore.jl",
    pages = [
        "Home" => "index.md",
        "Using file format specimens" => "testing.md",
        "Contributing" => "contributing.md"
    ],
    authors = "The BioJulia Organisation and other contributors."
)

deploydocs(
    repo = "github.com/BioJulia/BioCore.jl.git",
    julia = "0.6",
    osname = "linux",
    target = "build",
    deps = nothing,
    make = nothing
)

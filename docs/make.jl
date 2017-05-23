using Documenter, BioCore

makedocs()
deploydocs(
    deps = Deps.pip("mkdocs", "pygments", "mkdocs-material"),
    repo = "github.com/BioJulia/BioCore.jl.git",
    julia = "0.5",
    osname = "linux",
    latest = "master"
)

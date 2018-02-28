# BioCore.jl

| **Release**                                                     | **Documentation**                                                               | **Maintainers**                             |
|:---------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-------------------------------------------:|
| [![][release-img]][release-url] [![][license-img]][license-url] | [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url] | ![][maintainer-img] |


## Description

BioCore.jl provides core definitions that are common to all or many packages
in the BioJulia ecosystem.

It also includes a definition of a common IO interface for IO of Bioinformatics
formats in BioJulia packages, and includes some helper functions for generating
file parsers from state machine automata with Automa.jl


## Installation

BioCore is a dependency for other BioJulia packages, but you can install it
yourself with:

```julia
julia> Pkg.add("BioCore")
```

If you are interested in the cutting edge of the development, please check out
the master branch to try new features before release.


## Testing

BioCore.jl is tested against Julia `0.6` and current `0.7-dev` on Linux, OS X, and Windows.

| **PackageEvaluator**                                            | **Latest Build Status**                                                                                |
|:---------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|
| [![][pkg-0.6-img]][pkg-0.6-url] [![][pkg-0.7-img]][pkg-0.7-url] | [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url] [![][codecov-img]][codecov-url]        |


## Contributing and Questions

We appreciate contributions from users including reporting bugs, fixing issues,
improving performance and adding new features.
Please go to the [contributing section of the documentation](biojulia.net/Contributing/latest)
for more information.

If you have a question about
contributing or using this package, you are encouraged to use the
[Bio category of the Julia discourse
site](https://discourse.julialang.org/c/domain/bio).

[release-img]: https://img.shields.io/github/release/BioJulia/BioCore.jl.svg
[release-url]: https://github.com/BioJulia/BioCore.jl/releases/latest

[license-img]: https://img.shields.io/badge/license-MIT-green.svg
[license-url]: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE

[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://biojulia.github.io/BioCore.jl/latest
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://biojulia.github.io/BioCore.jl/stable

[maintainer-img]: https://img.shields.io/badge/BioJulia%20Maintainer-Ward9250-orange.svg

[pkg-0.6-img]: https://pkg.julialang.org/badges/BioCore_0.6.svg
[pkg-0.6-url]: https://pkg.julialang.org/detail/BioCore
[pkg-0.7-img]: https://pkg.julialang.org/badges/BioCore_0.7.svg
[pkg-0.7-url]: https://pkg.julialang.org/detail/BioCore

[travis-img]: https://img.shields.io/travis/BioJulia/BioCore.jl/master.svg?label=Linux+/+macOS
[travis-url]: https://travis-ci.org/BioJulia/BioCore.jl

[appveyor-img]: https://img.shields.io/appveyor/ci/BioJulia/BioCore.jl/master.svg?label=Windows
[appveyor-url]: https://ci.appveyor.com/project/Ward9250/biocore-jl/branch/master

[codecov-img]: https://codecov.io/gh/BioJulia/BioCore.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/BioJulia/BioCore.jl

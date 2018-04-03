# BioCore.jl

| **Release**                                                     | **Documentation**                                                               | **Maintainers**                             |
|:---------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-------------------------------------------:|
| [![](https://img.shields.io/github/release/BioJulia/BioCore.jl.svg)](https://github.com/BioJulia/BioCore.jl/releases/latest) [![](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE) | [![](https://img.shields.io/badge/docs-stable-blue.svg)](https://biojulia.github.io/BioCore.jl/stable) [![](https://img.shields.io/badge/docs-latest-blue.svg)](https://biojulia.github.io/BioCore.jl/latest) | ![](https://img.shields.io/badge/BioJulia%20Maintainer-Ward9250-orange.svg) |


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
using Pkg
add("BioCore")
#Pkg.add("BioCore") for julia prior to v0.7
```

If you are interested in the cutting edge of the development, please check out
the master branch to try new features before release.


## Testing

BioCore.jl is tested against Julia `0.6` and current `0.7-dev` on Linux, OS X, and Windows.

| **PackageEvaluator**                                            | **Latest Build Status**                                                                                |
|:---------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|
| [![](https://pkg.julialang.org/badges/BioCore_0.6.svg)](https://pkg.julialang.org/detail/BioCore) [![](https://pkg.julialang.org/badges/BioCore_0.7.svg)](https://pkg.julialang.org/detail/BioCore) | [![](https://img.shields.io/travis/BioJulia/BioCore.jl/master.svg?label=Linux+/+macOS)](https://travis-ci.org/BioJulia/BioCore.jl) [![Build status](https://ci.appveyor.com/api/projects/status/xl19qeob3gsgm8j7?svg=true)](https://ci.appveyor.com/project/Ward9250/biocore-jl)
 [![](https://codecov.io/gh/BioJulia/BioCore.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/BioJulia/BioCore.jl) |


## Contributing and Questions

We appreciate contributions from users including reporting bugs, fixing issues,
improving performance and adding new features.
Please go to the [contributing section of the documentation](biojulia.net/Contributing/latest)
for more information.

If you have a question about
contributing or using this package, you are encouraged to use the
[Bio category of the Julia discourse
site](https://discourse.julialang.org/c/domain/bio).

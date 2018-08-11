# BioCore.jl

[![](https://img.shields.io/github/release/BioJulia/BioCore.jl.svg?style=flat-square)](https://github.com/BioJulia/BioCore.jl/releases/latest) 
[![](https://img.shields.io/badge/license-MIT-green.svg?style=flat-square)](https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE) 
[![](https://img.shields.io/badge/docs-stable-blue.svg?style=flat-square)](https://biojulia.github.io/BioCore.jl/stable) 
[![](https://img.shields.io/badge/docs-latest-blue.svg?style=flat-square)](https://biojulia.github.io/BioCore.jl/latest)
![](https://img.shields.io/badge/lifecycle-stable-green.svg?style=flat-square)
[![](https://img.shields.io/badge/discord-chat-blue.svg?style=flat-square&logo=discord&colorB=%237289DA)](https://discord.gg/z73YNFz)


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

BioCore.jl is tested against Julia `0.7` and `1.0.x` on Linux, OS X, and Windows.

| **PackageEvaluator** | **Latest Build Status** |
|:--------------------:|:-----------------------:|
| [![](https://pkg.julialang.org/badges/BioCore_0.7.svg)](https://pkg.julialang.org/detail/BioCore) [![](https://pkg.julialang.org/badges/BioCore_1.0.svg)](https://pkg.julialang.org/detail/BioCore)  | [![](https://img.shields.io/travis/BioJulia/BioCore.jl/master.svg?label=Linux+/+macOS)](https://travis-ci.org/BioJulia/BioCore.jl) [![Build status](https://ci.appveyor.com/api/projects/status/xl19qeob3gsgm8j7?svg=true)](https://ci.appveyor.com/project/Ward9250/biocore-jl) [![](https://codecov.io/gh/BioJulia/BioCore.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/BioJulia/BioCore.jl) |


## Contributing

We appreciate contributions from users including reporting bugs, fixing
issues, improving performance and adding new features.

Take a look at the [CONTRIBUTING](https://github.com/BioJulia/BioCore.jl/blob/master/CONTRIBUTING.md) file provided with
every BioJulia package package for detailed contributor and maintainer
guidelines.


### Financial contributions

We also welcome financial contributions in full transparency on our
[open collective](https://opencollective.com/biojulia).
Anyone can file an expense. If the expense makes sense for the development
of the community, it will be "merged" in the ledger of our open collective by
the core contributors and the person who filed the expense will be reimbursed.


## Backers & Sponsors

Thank you to all our backers and sponsors!

Love our work and community? [Become a backer](https://opencollective.com/biojulia#backer).

[![backers](https://opencollective.com/biojulia/backers.svg?width=890)](https://opencollective.com/biojulia#backers)

Does your company use BioJulia? Help keep BioJulia feature rich and healthy by
[sponsoring the project](https://opencollective.com/biojulia#sponsor)
Your logo will show up here with a link to your website.

[![](https://opencollective.com/biojulia/sponsor/0/avatar.svg)](https://opencollective.com/biojulia/sponsor/0/website)
[![](https://opencollective.com/biojulia/sponsor/1/avatar.svg)](https://opencollective.com/biojulia/sponsor/1/website)
[![](https://opencollective.com/biojulia/sponsor/2/avatar.svg)](https://opencollective.com/biojulia/sponsor/2/website)
[![](https://opencollective.com/biojulia/sponsor/3/avatar.svg)](https://opencollective.com/biojulia/sponsor/3/website)
[![](https://opencollective.com/biojulia/sponsor/4/avatar.svg)](https://opencollective.com/biojulia/sponsor/4/website)
[![](https://opencollective.com/biojulia/sponsor/5/avatar.svg)](https://opencollective.com/biojulia/sponsor/5/website)
[![](https://opencollective.com/biojulia/sponsor/6/avatar.svg)](https://opencollective.com/biojulia/sponsor/6/website)
[![](https://opencollective.com/biojulia/sponsor/7/avatar.svg)](https://opencollective.com/biojulia/sponsor/7/website)
[![](https://opencollective.com/biojulia/sponsor/8/avatar.svg)](https://opencollective.com/biojulia/sponsor/8/website)
[![](https://opencollective.com/biojulia/sponsor/9/avatar.svg)](https://opencollective.com/biojulia/sponsor/9/website)


## Questions?

If you have a question about contributing or using BioJulia software, come
on over and chat to us on [Discord](https://discord.gg/z73YNFz), or you can try the
[Bio category of the Julia discourse site](https://discourse.julialang.org/c/domain/bio).


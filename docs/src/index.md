# BioCore.jl <small>Core definitions for BioJulia packages</small>

[![Latest Release](https://img.shields.io/github/release/BioJulia/BioCore.jl.svg)](https://github.com/BioJulia/BioCore.jl/releases/latest)
[![BioCore](http://pkg.julialang.org/badges/BioCore_0.5.svg)](http://pkg.julialang.org/?pkg=BioCore)
[![BioCore](http://pkg.julialang.org/badges/BioCore_0.6.svg)](http://pkg.julialang.org/?pkg=BioCore)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://biojulia.github.io/BioCore.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://biojulia.github.io/BioCore.jl/latest)
![BioJulia maintainer: Ward9250](https://img.shields.io/badge/BioJulia%20Maintainer-Ward9250-orange.svg)

**Development builds:**
[![Build Status](https://travis-ci.org/BioJulia/BioCore.jl.svg?branch=master)](https://travis-ci.org/BioJulia/BioCore.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/xl19qeob3gsgm8j7/branch/master?svg=true)](https://ci.appveyor.com/project/Ward9250/biocore-jl/branch/master)

BioCore.jl provides core definitions that are common to all or many packages
in the BioJulia ecosystem.

It also includes a definition of a common IO interface for IO of Bioinformatics
formats in BioJulia packages, and includes some helper functions for generating
file parsers from state machine automata with Automa.jl

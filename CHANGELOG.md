# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.5]
### Changes
- Fix the random_seq method. It used to use a convert method to convert char arrays to strings.
  Now it uses a String constructor.

## [2.0.4]
### Changes
- Fix another bug in the bio_fmt_specimens method.

## [2.0.3]
### Changes
- Fix the bio_fmt_specimens method to work with julia 1.0 syntax.

## [2.0.2]
### Changes
- Move some methods out of the largely unused Ragel module.

## [2.0.1]
### Changes
- Comment out some lines of Ragel.jl, with a view to completely removing them later.

## [2.0.0] - 2018-08-11
### Changed
- Compatibility for julia versions 0.7 and 1.0.

## [1.4.0] - 2018-04-25
### Added
- A HUMANS.md file listing the people responsible for the package.

### Changed
- Changelog is now manually curated.
- :memo: Documentation generation now uses Documenter.jl native html generator.

### Dependencies
- :arrow_up: Added support for julia v0.7.

## [1.3.0] - 2018-02-15
### Added
- Automatically generated changelog.

### Changed
- :memo: Documentation and CI updates.
- :bug: Dead link fixed. Thanks @kescobo!

### Dependencies
- :exclamation: Dropped support for julia 0.5.

## [1.2.1] - 2017-07-20
### Changed
- Updated the default commit of the get_bio_fmt_specimens function.

## [1.2.0] - 2017-07-16
### Dependencies
- :arrow_up: Upgrade Automa.jl dependency to v0.3. Thanks @bicycle1885!

## [1.1.0] - 2017-06-19
### Added
- A BioCore.Testing module useful for unit testing other BioJulia packages.

## [1.0.1] - 2017-06-14
### Dependencies
- :arrow_up: Added support for julia v0.6.

## [1.0.0] - 2017-05-23
### Added
- Basic project setup.

[Unreleased]: https://github.com/BioJulia/BioCore.jl/compare/v2.0.4...HEAD
[2.0.4]: https://github.com/BioJulia/BioCore.jl/compare/v2.0.3...v2.0.4
[2.0.3]: https://github.com/BioJulia/BioCore.jl/compare/v2.0.2...v2.0.3
[2.0.2]: https://github.com/BioJulia/BioCore.jl/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/BioJulia/BioCore.jl/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/BioJulia/BioCore.jl/compare/v1.4.0...v2.0.0
[1.4.0]: https://github.com/BioJulia/BioCore.jl/compare/v1.2.1...v1.4.0
[1.3.0]: https://github.com/BioJulia/BioCore.jl/compare/v1.2.1...v1.3.0
[1.2.1]: https://github.com/BioJulia/BioCore.jl/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/BioJulia/BioCore.jl/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/BioJulia/BioCore.jl/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/BioJulia/BioCore.jl/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/BioJulia/BioCore.jl/tree/v1.0.0

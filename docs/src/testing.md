# Using the BioJulia format specimen archive

BioJulia maintains an archive of different file formats
[here](https://github.com/BioJulia/BioFmtSpecimens).

To use these file specimens when creating unit tests for a package,
use the `bio_fmt_specimens` method to download / update the datasets, and return
the paths of specimen files that match some conditions (specified using
a function).

```@doc
bio_fmt_specimens
```

Then you can iterate through the returned paths and use them with whatever IO
methods you like.

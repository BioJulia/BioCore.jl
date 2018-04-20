var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#BioCore.jl-1",
    "page": "Home",
    "title": "BioCore.jl",
    "category": "section",
    "text": "Release Documentation Maintainers\n(Image: ) (Image: ) (Image: ) (Image: ) (Image: )"
},

{
    "location": "index.html#Description-1",
    "page": "Home",
    "title": "Description",
    "category": "section",
    "text": "BioCore.jl provides core definitions that are common to all or many packages in the BioJulia ecosystem.It also includes a definition of a common IO interface for IO of Bioinformatics formats in BioJulia packages, and includes some helper functions for generating file parsers from state machine automata with Automa.jl"
},

{
    "location": "index.html#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "BioCore is a dependency for other BioJulia packages, but you can install it yourself with:using Pkg\nadd(\"BioCore\")\n#Pkg.add(\"BioCore\") for julia prior to v0.7If you are interested in the cutting edge of the development, please check out the master branch to try new features before release."
},

{
    "location": "index.html#Testing-1",
    "page": "Home",
    "title": "Testing",
    "category": "section",
    "text": "BioCore.jl is tested against Julia 0.6 and current 0.7-dev on Linux, OS X, and Windows.PackageEvaluator Latest Build Status\n(Image: ) (Image: ) (Image: ) (Image: Build status) (Image: )"
},

{
    "location": "index.html#Contributing-and-Questions-1",
    "page": "Home",
    "title": "Contributing and Questions",
    "category": "section",
    "text": "We appreciate contributions from users including reporting bugs, fixing issues, improving performance and adding new features. Please go to the contributing section of the documentation for more information.If you have a question about contributing or using this package, you are encouraged to use the Bio category of the Julia discourse site."
},

{
    "location": "testing.html#",
    "page": "Using file format specimens",
    "title": "Using file format specimens",
    "category": "page",
    "text": ""
},

{
    "location": "testing.html#Using-the-BioJulia-format-specimen-archive-1",
    "page": "Using file format specimens",
    "title": "Using the BioJulia format specimen archive",
    "category": "section",
    "text": "BioJulia maintains an archive of different file formats here.To use these file specimens when creating unit tests for a package, use the bio_fmt_specimens method to download / update the datasets, and return the paths of specimen files that match some conditions (specified using a function).bio_fmt_specimensThen you can iterate through the returned paths and use them with whatever IO methods you like."
},

]}

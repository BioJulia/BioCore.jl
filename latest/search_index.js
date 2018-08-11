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
    "text": "(Image: )  (Image: )  (Image: )  (Image: ) (Image: ) (Image: )"
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
    "text": "BioCore.jl is tested against Julia 0.7 and 1.0.x on Linux, OS X, and Windows.PackageEvaluator Latest Build Status\n(Image: ) (Image: ) (Image: ) (Image: Build status) (Image: )"
},

{
    "location": "index.html#Contributing-1",
    "page": "Home",
    "title": "Contributing",
    "category": "section",
    "text": "We appreciate contributions from users including reporting bugs, fixing issues, improving performance and adding new features.Take a look at the CONTRIBUTING file provided with every BioJulia package package for detailed contributor and maintainer guidelines."
},

{
    "location": "index.html#Financial-contributions-1",
    "page": "Home",
    "title": "Financial contributions",
    "category": "section",
    "text": "We also welcome financial contributions in full transparency on our open collective. Anyone can file an expense. If the expense makes sense for the development of the community, it will be \"merged\" in the ledger of our open collective by the core contributors and the person who filed the expense will be reimbursed."
},

{
    "location": "index.html#Backers-and-Sponsors-1",
    "page": "Home",
    "title": "Backers & Sponsors",
    "category": "section",
    "text": "Thank you to all our backers and sponsors!Love our work and community? Become a backer.(Image: backers)Does your company use BioJulia? Help keep BioJulia feature rich and healthy by sponsoring the project Your logo will show up here with a link to your website.(Image: ) (Image: ) (Image: ) (Image: ) (Image: ) (Image: ) (Image: ) (Image: ) (Image: ) (Image: )"
},

{
    "location": "index.html#Questions?-1",
    "page": "Home",
    "title": "Questions?",
    "category": "section",
    "text": "If you have a question about contributing or using BioJulia software, come on over and chat to us on Discord, or you can try the Bio category of the Julia discourse site."
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

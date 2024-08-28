## Linked Text

For experimenting with knowledge representation and linking...

[Best Practices for Publishing Linked Data](https://www.w3.org/TR/ld-bp/#HTTP-URIS)

### Ontology
See [Baleen OWL](https://github.com/dstl/baleen/blob/master/baleen-rdf/src/test/resources/uk/gov/dstl/baleen/consumers/file/documentRelationsAsLinks.rdf)

I want to ask questions about the knowledge embodied in a text corpus. The traditional way to do this is to extract information from the corpus and populate a database, then ask questions of the database. This is all very well, but what if you and I want to ask questions about the same text corpus? Does one of us build a database we both query, or do we go our separate ways? What if we're interested in different things? We each might have insights about the corpus that would help the other, but how do we share them?

Some of these questions can be addressed through [ontology](https://en.wikipedia.org/wiki/Ontology), and in particular [its application to knowledge representation](https://en.wikipedia.org/wiki/Ontology_%28information_science%29). Good ontologies make data easier to explore and share, but you must build your ontological model before you can build a database around it, and the problem of extracting and structuring information from the text corpus to populate the database is not trivial. Once these problems are solved, then ontological knowledge bases are the way to go; but it's a lot of work to get to that point, and a lot depends on you knowing what sort of information is in the text corpus, and what questions you want to ask of it.

I want to treat a text corpus as a if itself were a database. I want start asking questions about it without fully understanding it. This is _sensemaking_. I accept that asking complex questions requires complex data structure to be derived from the text, but I want to iterate towards more complex knowledge structures rather than having to design them up front. In particular, I want to be able to ask very simple questions with little or no effort or prior knowledge. I'll necessarily build and extend models of the knowledge as I explore, but i want to be able to change these more or less on a whim.

I'll need [Natural Language Processing (NLP)](https://en.wikipedia.org/wiki/Natural_language_processing) to get any information out of text. Simple [Named Entity Recognition (NER)](https://en.wikipedia.org/wiki/Named-entity_recognition) can get me going.

I need to construct some sort of information model from the text in order to ask questions or drive further analysis. I'll aim to come up with a simple models for simple questions, and think about how those models might join together as questions become more complex. I don't want to depend too heavily on any particular model. I'd like to be able to generate the right knowledge structures and information extraction processes 'on the fly' to answer each question as its asked. Not efficient of course, but I'm more interested in developing techniques than I am a knowledge bases. It's about transformation and composition.

I don't want to put pressure on NLP processes to get things right (they often don't). Instead of treating the results of NLP as facts, I'll treat them as a _claims_ that I can simply accept if I'm not too bothered about accuracy, or can subject to checking if I am. This is argumentation, and if I arrange it so that one process can confirm or deny the results of another, it's a [multi-agent dialogue](https://knoxa.github.io/dialogue/).

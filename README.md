For experimenting with knowledge representation and linking...

## Linked Text

I want to ask questions about the knowledge embodied in a text corpus. The traditional way to do this is to extract information from the corpus and populate a database, then ask questions of the database. This is all very well, but what if you and I want to ask questions about the same text corpus? Does one of us build a database we both query, or do we go our separate ways? What if we're interested in different things? We each might have insights about the corpus that would help the other, but how do we share them?

I want to treat a text corpus as a if itself were a database. I want start asking questions about it without fully understanding it. This is _sensemaking_. I accept that asking complex questions may require a complex data structure to be derived from the text, but I want to iterate towards more complex knowledge structures rather than having to design them up front. In particular, I want to be able to ask very simple questions with little effort or prior knowledge. I'll necessarily build and extend models of the knowledge as I explore, but I want to be able to change these more or less on a whim.

I will need to construct information models from the text in order to answer more difficult questions or drive further analysis. I'll aim to come up with a simple models for simple questions, and think about how those models might join together as questions become more complex, but I don't want to depend too heavily on any particular model. I'd like to be able to generate the right knowledge structures and information extraction processes 'on the fly' to answer each question as it's asked. Not efficient of course, but I'm more interested in developing techniques than I am a knowledge bases. It's about composing and applying transformation processes to generate models from text. I want to be able to share these models, so I'll express them as [linked data](https://www.w3.org/TR/ld-bp/).

### Ontology

The models I want to develop and share are defined by [ontologies](https://en.wikipedia.org/wiki/Ontology_%28information_science%29). Lots of these exist, and many are designed as components, or as abstract models that can be extended and customized. It's best practice to reuse rather than invent, so I'll make use of these:

* [Baleen OWL](https://github.com/dstl/baleen/blob/master/baleen-rdf/src/test/resources/uk/gov/dstl/baleen/consumers/file/documentRelationsAsLinks.rdf) - For expressing the results of [Natural Language Processing (NLP)](https://en.wikipedia.org/wiki/Natural_language_processing).
* [SKOS](https://www.w3.org/2004/02/skos/) - To identify, label and classify simple entities.
* [OWL Time](https://www.w3.org/TR/owl-time/) - For temporal properties and relationships.
* [IES4](https://github.com/dstl/IES4/) - To Model events and state, and relationships between entities. 

### Multi-agent dialogue

I don't want to put pressure on NLP processes to get things right because they often don't. Instead of treating the results of NLP as facts, I'll treat them as a _claims_ that I can simply accept if I'm not too bothered about accuracy, or can subject to checking if I am. This is [argumentation](https://dstl.github.io/eleatics/doc/argumentation/), and if I arrange it so that one process can confirm or deny the results of another, it's a [multi-agent dialogue](https://knoxa.github.io/dialogue/). The use of Baleen OWL in the ontology mix supports tracing the provenance of claims back to the original text.

The same multi-agency principle applies when reasoning over extracted information to infer new knowledge. Claims can be made by one agent, then confirmed or denied by another. Claims that are ambiguous or uncertain can be questioned. I'll use the [Argument Interchange Format (AIF)](https://www.arg.tech/index.php/research/contributing-to-the-argument-interchange-format/) to model this dialogue.

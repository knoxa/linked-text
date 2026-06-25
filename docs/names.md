# NER

## People

- *LoadTextDatabase* - Read XHTML file. Treat HTML articles in XHTML files as documents: Find articles with Xpath.
Parse, with article node as parent, using *HtmlParser*. Save the Html structure and attributes to an Html database with some identifier.
Save the text content to a Text Database with the same identifier.

NLP operates on the Text database.

- Shallow parse Text database - Operate on text strings covered by HTML paragraph (article?) elements: Sentence splitting, tokenization and POS tagging.

- Annotate text - Database matching: For names of people, for names of civilians (so names that aren't of interest can be found and removed from further consideration).
For ranks and titles.
Regular expression matching: For service numbers. Optionally, noun phrase chunking.


- Modify annotations - SQL utilities to clean up overlapping annotations, remove civilians.


- Query to select documents from database, then serialize to Baleen XML. Can use XSLT-Parsers to perform NLP on this XML.


### Building dictionaries

For a historical text, I want a list of all mentions of names within the text. I get this by iteration.
I can start with a seed dictionary of ranks and titles, a dictionary of suffixes, perhaps a few common forenames or surnames.
I shallow parse to create noun phrases and apply the dictionaries. Perhaps also regular expression matching for service numbers.
I select unique noun phrases that contain dictionary terms, and make this the basis of a Names dictionary.
I can use NLP to apply rules in making this selection if I want. For example, I might select all noun phrases that start with a rank.
I can iterate this process, making changes to the seed dictionaries as I go, and collecting more names in the Names dictionary.
At some point, I can switch to applying just the names dictionary.
I can serialize the results as HTML, marking up names in the output, and scan the results to assess quality. (xsl/html-new.xsl)
I can then add or remove entries as I see fit.

I can try applying simple dictionaries to XHTML. I need to at least segment text by sentence because any annotations created by dictionary matching 
will be nested inside sentences. I can take a serialized collection of document, text, sentence and annotation elements and create HTML for the purpose of visualizing dictionary hits. The generated HTML as an article per document, and a paragraph per sentence. Dictionary hits are spans with the class attribute set.
(markup-dictionary.xsl).


## Names dictionary

This is simply a list of mentions of person name.
In context they are mentions of people, but out of context there is no way of knowing if an entry in the dictionary refers to one individual or several. 
An individual may be referred to by many entries in the dictionary.
Applying the dictionary to text gives context to the mentions.

## Sources of names

* Assume that a _span_ element with a _class_ attribute labels an entity.
Assume that a _content_ attribute, if present, specifies a preferred label.

Spans might be used in this way to resolve anaphors. If so, the specified content is likely to be ambiguous outside a narrow scope.
A narrow context can be acknowledged by only using spans within the sentence or paragraph during NLP.
However, it may be useful to use spans in a wider context, or from a different document, in which case ambiguity will be an issue. 

* Names may come from RDF models. Entity names are label properties, SKOS or RDFS say.
A SKOS _prefLabel_ explicitly defines a preferred name.

Preferred names should be unique within the same model, but they might not be.
Different models of the same domain (with different modellers) may well have different preferred names for the same entity.
Models generated from XHTML+RFDa are likely to be less 'rigorous' than those directly crafted by knowledge engineers.

### Issues

1. A map of entity label to preferred label may give more than one preferred label if there are multiple sources.

2. One label may be a substring of another.

How these issues are resolved may depend on what some application is trying to achieve.

### Normalization

Make a map from alternate label to preferred label.

## Identity

I can construct a master list of entities as XHTML+RDFa.
At minimum, I need a URI and a label. Preferably, I have a URI and multiple labels, one of which is a preferred label.
Optionally, an entity type.

I construct these artifacts:

* A list of labels. This is for dictionary lookup.
* A map of label to URI. This map has the label as key, and a set of URI's as value.
The reason for the value being a set is that the same label might be used by two different entities - it might be ambiguous. 
* A map of URI to preferred label. This map also has a set of labels as its value, though there should only be one.

### In XHTML

On a HTML *span*:

* If I have a *@class* attribute that identifies an entity type, I can make a blank node identifier (in place of URI) and make the span contents a *skos:altLabel*.
* If I also have the *@about* attribute, I make that the URI.
* If I also have the *@content* attribute, I make the value of that the *skos:prefLabel*.

### Recording results

I can put plain text through NLP, find and identify entities though dictionary match and lookup, and record the results as XHTML+RDFa.
I can save lookup as XML that can easily deserialized for use in NLP.
Should I do both?


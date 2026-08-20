## Named entities

Some terminology:

* A *mention* of an entity is a span of text at a particular position in a source document that names or describes it.
The position of a mention gives it *context*.

* A *label* is a string of text that names or describes an entity. It is a mention taken out of its source context.

* An *entity* is the thing represented by the set of labels that name or describe it.

The process of finding mentions in text is *Named Entity Recognition (NER)*.
Determining that different mentions are about the same entity is *coreference resolution*.
Identifying a mention to a specific entity is *entity linking* or *entity disambiguation*.

### Identity

A concrete, real-world entity is a unique thing that has an identity.
An entity is identified by assigning it an *identifier*.
Ideally the identifier is globally unique, but I may choose to use a proper name as an identifier and accept that it may be ambiguous.

### Context

Meaning depends on context.
A label may be put in context by association with mentions of it.
It may also be put into context by association with other labels that are deemed equivalent by coreference resolution.

### A Pragmatic approach

It's easier, from the data management point-of-view, to deal with labels rather than mentions when collecting references to the same entity.
Simplifying a set of mentions to a set of labels risks losing contextual information that might change the determination of the associated entity.
Mistakes are always possible in any case, and I'll assume that operating on labels instead of mentions isn't going to add significantly to the risk of misidentification.
What will happen is that some entities won't be identifiable from considering labels that might be identifiable through considering mentions.
I'll assume that these lapses aren't important.

I will tend to use proper names as identifiers.
This is wrong in general terms because proper names aren't unique, but it usually works in a narrow context.
Rather than claim that an entity is identified by its name, I say that I assume an entity is identified by its name.
If I need to be more formal, I'll use globally unique identifiers from a publicly available knowledge base such as [DBpedia](https://www.dbpedia.org/).

### Provenance

Any "facts" I extract are not, in actual fact, facts, but are claims based on a set of assumptions.
These assumptions will usually be correct, but might not be in particular circumstances.
My claims are also the result of applying a sequence of processes to the source text, any of which might introduce some error.

You should be able to test a claim by challenging the analysis and underlying assumptions and I should be able to justify assumptions to defend it.
I should therefore back up my claims with provenance.
That is to say, I should provide supporting information that allows a claim to be traced back to the historical source text that ultimately justifies it.

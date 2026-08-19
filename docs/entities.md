# Named entities

* A **mention** is a span of text, at a particular position in a source document, that names or describes an entity.

* A **label** is a string of text that names or describes an entity. It is a mention taken out of its source context.

* An entity is represented by the set of labels that name or describe it.

* An entity is identified by assigning it an **identifier**.
Ideally the identifier is globally unique, but we may choose to use a proper name as an identifier and accept that it may be ambiguous.


The process of finding mentions in text is *Named Entity Recognition (NER)*.

Determining that two mentions are about the same entity is *entity disambiguation*.
This might be *within document* or *cross document*.
Entity disambiguation might operate on mentions or labels.

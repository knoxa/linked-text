
# Issues

How to use RDFa?
Can get complicated ...sequences ...
conventions for sequences?


What is the type of object represented by a "claim"? If I make it a string, how do I use it again later without having to phrase the claim in exactly the same way? If I give the claim an *about* attribute, I can use that to refer to it. However, RDFa now expects the claim to be a resource node rather than a literal type. I can make it an aif:I-node or a skos:Concept, or perhaps leave it untyped, and make the text of the claim a string property.

For sequences:

The HTML **ol** element implies a sequence. Should I also make this explicit through RDFa mark-up?

What structure is it that goes forward for mathematical processing? Can I get from some conventional use of HTML to a more formal presentation in RDA mark-up by applying an XSL transform (like adding "about" attributes for unidentified claims).

Do I need to use RDFa for anything other than basic labelling of types. If so, can I justify that?

What is the difference between a state and an event? How do I align a state with a chronology? (e.g. movements of some particular entity)


# Chronology

Each HTML article represents a disjoint time **interval** or **instance**. These are assumed to be in time order, earliest first.

* The output from each article is a set of **event**, with a child **interval** element, one for each claim. The *fm* and *to* attributes on this interval are set according to the position of the HTML article in the document. Some details to work out here regarding difference between instants and intervals. Also, what to do with nested events (and sequences within articles).

The output consists of an **event** for each claim made in the HTML document. Any spans within the claim are mapped to child **entity** elements. Each **event** has a child **interval** element with *fm* and *to* attributes that depend on the position of the containing HTML article element within the HTML document.
Each element has a *uri* attribute. This is the value of the RDFa *about* attribute on the claim if that is set, or the eleatics hash of the claim text if not.

A final step looks for claim elements that are children of a containing element labelled rdf:Seq. These are assumed to appear in time order, and are *link* elements are added to the output accordingly.

# Principles

I want the same argument to have the same URI wherever it is used. It should be possible, but not mandatory, to explicitly assign a URI. If not, I will assume that two arguments are the same if their text is the same (same hash - maybe some pre-processing before hashing). Hashing to construct a URN gives a global context, hashing to construct a blank node identifier gives a local file context.

What sort of claims are there? I want Event for chronology. How about State? Does this differ from Event in terms of chronology? Can I assume all claims are events if an article is of type time:Interval or time:Instance?

# Output

Output is *events*. I'm not concerned whether these are intervals or instants at this stage.

In the output, I model both time:Instant and time:Interval elements with an **interval** element that has *fm* and *to* attributes. This is intended solely for determining time order. The attributes are simply numbers, they do not represent specific times. The *to* value is greater than the *from* value for interval events, and equal to the *to* value for instant events.

# post-Processing

Take a series of "X is in Y" claims. Make them a sequence. This means they must a a URI in the source doc, or be referred to by the same text 

I want to be able to recover all claims from "workbooks". Then process like "WebPage". I want the text of the claim labelled by URI as a "short document".
* Ned some sort of "index" document. How does this affect something like "chronology"?

# Input chunking

If I operate with whole claims, I can do things like associate a person with a role when there is just one mention of each entity type. Often there will be more than one person or role in the sentence. If there's only one role, or only one person, then its reasonable to assume the role is related to each person, or the person related to each role. I can't make this assumption if there are multiple people and roles (a list of cabinet appointments say). Regardless,
I can do FCA on all claims that mention people and roles, with the events as objects and the entities mentioned as attributes. If there are any events that just relate a given person to a given role, then they will be the objects at the meet of the the person and role attributes.

... FCA for entities, use meets to define relationships.

# People (named entities)

When a span of text is a _name_, it may be the name of a person. A person may have more than one name. Two different people may have the same name. A person may be introduced in a text with their full name, then referred to later by a shorter version of the name.

Collect sets of strings that represent names of a person. Make one of these a preferred label (terminal object). Need some way of determining preferredLabel if one isn't assigned: longest name, or first/last in sort order. Can take a set of names and make a SKOS Concept.

We may have a co-reference link between two names. Treat this is as an equivalence relationship and form a set - then as above.

## processing XHTML

The aim is to generate SKOS Concepts from HTML span elements. The span element may have a @content attribute. If it does, then this is assumed to be the preferredLabel of a SKOS concept and the surface text is the altLabel. If it doesn't, then the surface text is assumed to be the preferredLabel.

A span of text may _reference_ a person without necessarily be in a name.

# XML

The processes covered here both consume and produce XML data. They can be linked via XSL Transformations. I'll use standard formats where possible (XHTML, RDF/XML etc)
but occassionaly  simple bespoke formats for intermediate files. The use of these is for review later.

## Events



## Context

This is a context in the FCA sense. Objects are identified by URI. You can specify multiple objects with the same URI and they will represent the same object. 

# TO DO

1. Need a named template from add-uri to make a hash code.

Take entities in a workbook and make a dictionary from spans and @content attributes. Maybe make SKOS concept and the a 'concept dictionary'? Have I already done this?
SKOS concepts from DBpedia

noun phrase chunking - create an entity list of vessels as WW1 "knowledge"? - 

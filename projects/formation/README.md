# Military formations

Each sentence in [formation.xhtml](https://tigersmuseum.github.io/history/units/formation.xhtml) is a claim about the relationship between a larger and smaller military unit that pertains at some particular time.
I treat these claims as events and construct a partial order: [results/events.graphml](results/events.graphml).

## Timelines 

The units associated with events are made explicit through semantic mark-up, but the dates associated with each event must be recovered through NLP.
I perform tokenization, part-of-speech tagging, make annotations from HTML spans, and identify dates. The result is [formation.xml](input/formation.xml) in [Baleen XML](https://dstl.github.io/eleatics/nlp/) format.

The **parse** target in [build.xml](build.xml) applies my [ATN parser](https://github.com/knoxa/xslt-parsers/tree/main/ATN) performs phrase chunking on *formation.xml* to produce an intermediate file (also in Baleen XML format) called *parsed.xml', which is processed by [xsl/nlp-event.xsl](xsl/nlp-event.xsl) to generate event XML.

## Unit composition

The timeline only requires that units of interest are entities mentioned in the same event.
It doesn't care about parent-child relationships between units.
This unit structure is in the claims though.
The same NLP output (*parsed.xml*) can be put through [nlp-part.xsl](xsl/nlp-part.xsl) to produce an ordering of units.
The result is [part.graphml](results/part.graphml).

## Identity

The constructed events include entities, which are the military units mentioned.
I can sequence events about the same unit to make a timeline provided I know which mentions are about the same unit.
To help with this, I create some master data to resolve mentions of units. This is [units.xhtml](https://tigersmuseum.github.io/history/units/units.xhtml).
It is marked up to define units with a URI for each, a preferred label for each, and an optional set of alternate labels.

I construct two maps:

* [labels.xml](input/labels.xml) - Maps alternate label to preferred label. This includes the explicit mapping in *units.xhtml* and the mapping implied by the use of `@content` attributes on HTML span elements in *formation.xhtml*.

* [prefs.xml](input/prefs.xml) - Maps preferred label to URI. This is constructed from *units.xhtml*.

The preferred label I specify with `@content` in *formation.xhtml* should ideally match a `skos:prefLabel` value in *units.xhtml*.
It won't necessarily, because I may not refer to *units.xhtml* before modifying *formation.xhtml* (or at all).
This doesn't matter as long as the preferred label in *formation.xhtml* is one of the appropriate `skos:altLabel` value in *units.xhtml* as
I can use the [labels.xml](input/labels.xml) map to get the right label.

It might be that the *formation.xhtml* preferred label isn't in *units.xhtml*  at all.
This doesn't matter if I'm assuming that the preferred label of a unit identifies it.
If I'm trying to be more formal, and use URI's as unit identifiers, then I need to make sure that the preferred label is a key in the *prefs.xml* map.
The simplest way to do this is to add an entry for the unit to *units.xhtml*.

## Notes

If several things happen at some unspecified time within the same larger interval then they are not comparable with each other, but they are all comparable with events that precede or follow the interval.
This adds a lot of edges to the graph. It's not an issue from the mathematical point-of-view, but leads to clutter if you just want a visualization of events.
One way to reduce clutter is to restrict the graph to just a few units. This can be done by XSL transforms that filter the events before ordering them.
An alternative would be to collect the claims covering the same time interval into a single event.



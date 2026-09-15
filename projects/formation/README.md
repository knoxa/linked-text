
_input/formation.xml_ - The output from NLP of text from [formation.xhtml](https://tigersmuseum.github.io/history/units/formation.xhtml):
shallow parse, make annotations from HTML spans, identify dates. This file is Baleen XML.


Each sentence in _formation.xml_ is a claim about the relationship between a larger and smaller military unit that pertains at some particular time.
I treat these claims as events and construct a partial order: [results/events.graphml](results/events.graphml).

The constructed events include entities, which are the military units mentioned.
I can sequence events about the same unit to make a timeline, provided I know which mentions are about the same unit, given that there may be some variation in how the unit is named.


I create some master data to resolve mentions of units. This is [units.xhtml](https://tigersmuseum.github.io/history/units/units.xhtml).
It is marked up to define units: a URI for each, a preferred label for each, and an optional set of alternate labels.

I construct two maps:

* [labels.xml](input/labels.xml)  - maps alternate label to preferred label.
* [prefs.xml](input/prefs.xml)    - maps preferred label to URI.



_intput/dictionary.txt_ - A list of proper names extracted from [formation.xhtml](https://tigersmuseum.github.io/history/units/formation.xhtml) and [units.xhtml](https://tigersmuseum.github.io/history/units/units.xhtml).


_input/formation.xml_ - The output from NLP of text from [formation.xhtml](https://tigersmuseum.github.io/history/units/formation.xhtml):
shallow parse, dictionary lookup, identification of dates. This file is Baleen XML.


Each sentence in _formation.xml_ is a claim about the relationship between a larger and smaller military unit that pertains at some particular time.
I can convert formation.xml to even
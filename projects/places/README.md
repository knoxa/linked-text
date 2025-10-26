# Places

Disambiguating mentions of people in a WW1 chronology.

## Input

* **[places.txt](https://tigersmuseum.github.io/history/events/ww1/places.txt)** is a list of places mentioned [World War I chronology](https://tigersmuseum.github.io/history/docs/ww1.html).


## Regions

Places in text are often mentioned in relation to other places. Many of the entries in **places.txt** have other entries as substrings.
Often, a town or city name is given with the name of a larger region or country in brackets. There is an implied "this place is part of that place" relationship that I can try to pull out.

I can process **places.txt** to make [context.xml](results/context.xml). The objects and attributes are entries from **places.txt", with attributes being 
entries that are proper substrings of the object string.

I apply FCA to [context.xml](results/context.xml) to produce [lattice.xml](results/lattice.xml).
The concepts at the "top" of this lattice are associated with the most common attributes, which tend to be the more often mentioned regions and countries.

I assume that each top concept represents a region or country, and that attributes below that concept represent places with that region.
I make a new context accordingly: [hypothesis.xml](results/hypothesis.xml). Effectively, this makes a series of claims:

	{attribute} is a place in {parent object}

These claims are not always correct. The aim now is to confirm or deny them.

You can see from the FCA lattice that we often have a town within a region, then that region within a country.
This structure is collapsed by the processing above, so that we know that both town and region are in the country, but lose the information that the town is in the region.
We can address that loss later.


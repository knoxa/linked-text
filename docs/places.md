# Places

## Locations

A place may be locatable. The location may be unknown.
A location has one or more names.
There can be more than one place with the same name.

* places.xml - map of name to preferred name.
* geometry.xml - place names and associated geometry.
* geometry.kml - place names and associated geometry.

Can capture alternate names in KML (SKOS in ExtendedData).

No GIS ...

Store geometry as KML.
Allow simple maps of alternate place name to preferred place name. This lets me collect and manage place names when I don't know where they are.
Use polygons for context. Ensure that there are polygons that distinguish between locations with the same name.
Construct partial order of places related to places by containment. This can be done either by point inclusion in polygons, or by simple assertions.

For a given KML, can calculate the convex hull - then use that as context. Can construct polygons for context.

* construct dictionaries from KML/lookups for NLP. Classify text by locations (using polygons?)

## Data collection

Collect places in Google Earth. Which spellings? 
Can extract geometry XML from KML, include alternate labels in geometry (or KML)

KML -> dictionary (places.xml)


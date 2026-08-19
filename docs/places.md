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

## Markup

What text represents a place? What do we want to mark up? Do we want to mark up everything?

A place may be located with respect to another "well known" location. We want a gazetteer of such reference locations.
We want to use locations differently in different circumstances. Granularity. 

Everything is context dependent.

## Data Structures

Can collect places as *folders* in KML. Perhaps a folder for an event. Can use RDFa with KML. Does this give anything over using _ExtendedData_?
Can make a folder per date, or a folder per event. One advantage is that it makes navigation in Google Earth easier (click on folder to orient on covered placemarks).

Can collect geographic data as XHTML+RDfa. Might be useful in making gazetteers. Conversion to/from KML.
Don't always need/want/know the location of a place.

Separate collecting places names from geolocating them? Need to get a list of place names for known location.
Need to know what names are already located.

---

* Use placemark names in KML to construct dictionaries. Find those term in text.
* Find placenames in text, then geolocate them.

Need to deal with alternate labels and ambiguity. Identifying a term as a place is independent of these concerns.
The issues arise when you try assert equivalence between terms, or when you try to geolocate terms.
Two terms that have the same location can be assumed to be equivalent.
Alternatively, if one of them is a known location, equating terms might help locate the other.

Geolocating a place help classify it. Can also classify places in various ways without geolocating them first - and these classifications can aid geolocation.

Ambiguity doesn't have to be resolved.
It may be enough to be only aware of ambiguity of the location of some place, and make a judgement as to whether that affect decision making.
If it's important to resolve a particular ambiguity then further analysis can be made, or more data collected.

The inverse of geolocation is assigning a label to a geometry. This may or may note be needed in any given application.
Different labels may be appropriate in different contexts.

The association between label and location depends on context. Different associations will be useful in different contexts.

Can add some structure to KML using folders: Geometries in the same folder are associated in some way.
Can make explicit associations in KML using ExtendedData element or RDFa markup.
For example, the location of a military operation may be a collection of points in a folder.


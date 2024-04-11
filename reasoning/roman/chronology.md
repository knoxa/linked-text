# Chronology

Something (anything) that happens is an *event*. It happens over an *interval* of time, or at a specific point *instant* in time.

For the purposes of the maths that follows, an interval is an open set delimited by start and end instants. Every event has a start time and an end time returned by the functions Start(x) and End(x). If the event happens over an interval these return the start and end instants respectively. If the event happens instantaneously then it starts and ends at the same time.

I want a [partial order](https://en.wikipedia.org/wiki/Partially_ordered_set) on events that tells me if one event happens before another: Given two events, x and y, x <= y if the events are identically equal (i.e. the same event), or End(x) <= Start(y). if x <= y and y <= x then x = y. I'll call this relation *before*, and also say that if x is before y, then y is *after* x.

Points to note:

* Two interval events are only comparable if one ends before the other one starts. The relation has nothing to say about overlapping events or events that happen during an interval event.
* An interval event is after its start instance and before its end instance.


Given this partial order, the events in [chronolgy.xhtml](chronology.xhtml) generate the graph in [chronology.graphml](chronology.graphml).
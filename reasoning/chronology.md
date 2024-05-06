# Chronology

Something (anything) that happens is an *event*. It happens over an *interval* of time, or at a specific *instant* in time.

For the purposes of the maths that follows, an interval is an open set delimited by start and end instants. Every event has a start time and an end time returned by the functions Start(x) and End(x). If the event happens over an interval, these return the start and end instants respectively. If the event happens instantaneously, then it starts and ends at the same time.

I want a [partial order](https://en.wikipedia.org/wiki/Partially_ordered_set) on events that tells me if one event happens before another: Given two events, x and y, x <= y if the events are identically equal (i.e. the same event), or End(x) <= Start(y). I'll call this relation *before*, and also say that if x is before y, then y is *after* x.

Points to note:

* Two interval events are only comparable if one ends before the other starts. The relation has nothing to say about overlapping events or events that happen during an interval event.
* An interval event is *after* its start instant and *before* its end instant. Therefore, because intervals are open, an interval will be *before* another that starts at the same time it ends.

## Order from text

A partial order of events may be apparent in a historical text even if precise timings aren't. For example, The Annals of Tacitus relate events to Roman consulships, which are contiguous time intervals. Other intervals can be constructed from the text, such as the reign of an emperor. Some event order can be be inferred. For example, people are born before they die, and they are born after any of their ancestors and before any of their descendants. An [example](https://knoxa.github.io/examples/chronology/example.xhtml) gives a flavour of this analysis. An extension of this example can be found in [chronology.xhtml](roman/chronology.xhtml), which produces the graph in [chronology.graphml](roman/chronology.graphml).
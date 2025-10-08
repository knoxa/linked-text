# Chronology

Utilities for ordering events. These operate on an **event XML** (to be documented when the details settle).


- **make-sortable.xsl** adds an _interval_ element to each event. The _@fm_ and _@to_ attributes on this element are numbers. A larger number indicates a later point in time.

- **sort.xsl** uses the _interval_ element to sort events, first by increasing value of the _@fm_ attribute, then by increasing value of the _@to_ attribute.

- **entity-graphml.xsl** builds a GraphML format graph. Each node is an event, and edges links from one event to the next that mentions the same entity. The stylesheet assumes the input is in sorted order.

- **event-order.xsl** builds a partial ordering of events. Events are considered as intervals, and only non-overlapping events are comparable. Each node is an event, and edges links from one event to any events that cover it. The stylesheet assumes the input is in sorted order.

- **order-graphml.xsl** Transforms a partial ordering of events to GraphML.

- **partition.xsl** Optionally, partition sorted events. Ordering only happens within a partition.
The _@name_ attribute on the partition becomes the _reason_ property in GraphML edges.

# Graph Operations

These XSL Transformations consume and produce GraphML:

* __covers.xsl__ - Given a directed acyclic graph, remove any longer paths between nodes directly connected by an edge.
If the graph represents a partial order, this restricts edges to _covers_.
* __filter-edgeless.xsl__ - Remove nodes that have no edges.
* __filter-duplicate-edge.xsl__ - Keep at most one edge between nodes.
* __filter-self-edge.xsl__ - Remove edges from a node to itself.
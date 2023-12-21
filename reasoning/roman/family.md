# Julio-Claudian Family Tree

From [family.xhtml](family.xhtml) we generate [julio-claudian.graphml](julio-claudian.graphml), which looks like this ...

![Julio-Claudian Family Tree](julio-claudian.svg "Julio-Claudian Family Tree")


## How it works

The steps are: 

1\. Transform [family.xhtml](family.xhtml) to AIF with [claims.xsl](../../xsl/claims.xsl).

2\. Evaluate the AIF. There are some choices to be made about how to do this. I apply the [presumptive arguments](https://dstl.github.io/eleatics/argumentation/explain-framework.pdf) method using the code in my [argumentation](https://github.com/knoxa/argumentation/) repository. I want 'agreed facts' in the next step, so I select I-nodes that are 'acceptable information' with respect to the grounded extension. Ideally, conflicts are resolved in the AIF so that the grounded extension is the only extension. If not, then it's back to [family.xhtml](family.xhtml) to add to the dialogue. I want my assertions to take precedence if they conflict with notional NLP agents (I'm always right if I say "this is wrong"), so I evaluate the AIF with suitable preferences.

3\. Transform the acceptable information to XHTML using [family.xsl](../../xsl/family.xsl). This is effectively selecting and rewriting the arguments that are about lineage in terms of parent-child relationships. A grandparent relationship implies an intermediate unknown parent and a sibling relationship implies an unknown common parent; so, for example,

	Agrippa Postumus is the grandson of Augustus
	
becomes

	Augustus is the parent of ?, and ? is the parent of Agrippa Postumus.

4\. Make GraphML from the results with [family-graph.xsl](../../xsl/family-graph.xsl). This graph needs some cleaning up: It may have multiple edges between nodes if the dialogue claims the same fact more than once (confirmation), and it will have redundant unknown '?' nodes (i.e. that are equivalent to named nodes). The (still experimental) [graph-clean.xsl](../../xsl/graph-clean.xsl) stylesheet does this.
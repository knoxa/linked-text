
#Argument in XHTML

## Mark-up

Any HTML node labelled with a *class* attribute value of **claim**, **premise** or **conclusion** maps to an AIF I-node. I'll call an HTML node with one of these class a *claim node*.

### Identifying claims

Optionally, you can explicitly identify a claim by adding an *about* attribute to the claim node. Any arguments you don't identify yourself will get *about* attributes added by the system. This applies [add-uri.xsl](xsl/add-uri.xsl) as the first step in the processing, using the [eleatics string hash](https://github.com/dstl/eleatics/blob/master/xsl-utils/stringhash.xsl) to construct URNs.


### Referring to arguments

You may want to use claims made elsewhere in the HTML document as premises or conclusions. If you've added your own URI then you can just use that. Alternative, you can repeat the text of an earlier claim. Because default identities are created using string hashing, the same claim text will always give the same claim identity.

### If-then rules

	<p class="premise">
		If <span class="premise">Tigranocerta is a city in Armenia</span>, 
		and <span class="premise">Nisibis is near Tigranocerta</span>, 
		<span class="support">then</span> 
		<span class="conclusion"><span class="place">Nisibis</span> is a town in <span class="place">Armenia</span>.</span>
	</p>

### Rewriting names

Identifying potentially ambigusous names or anaphors... Use the *content* attribute on a *span* element to assert a canonical name. In "family" I have a "rewrite" rule that justifies this change. See (REWRITE DOC)

### Questions

...

## TO DO

define claims that are conclusions of blockquoted text. Can "Nisibis is near Tigranocerta" premise be linked from blockquote?
... Need to think about conventions that link claims to blockquotes

Allow quotes from quotes? (i.e. blockquote as both premise and conclusion?)

process claims drawn from quoted text in claims-quote.xsl?

A named graph for each HTML article?


#XSL process

1. mode="list" - claims-info.xsl - Make all I-nodes.
2. mode="quote" - claims-quote.xsl - Make quoted text the conclusions for "sources"

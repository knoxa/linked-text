# Multi-agent dialogue

The raw data is [a set of names](input/names-67.txt).
I want to partition this data so that all the names that belong to the same person are grouped together.
I model the process as a dialogue in which agents generate hypotheses, and I evaluate support and contradiction among these hypotheses to produce a consensus.

## Hypotheses

In this context, a _hypothesis_ is set of names that an agent claims belong to a distinct person.
I'll call a hypothesis _consistent_ if the names to belong to the same person, and _complete_ if all the names for that person (in the input data) are included in the hypothesis.
I'll call a hypothesis _correct_ if it is both consistent and complete.

Restating the problem, I want to partition the names into correct hypotheses. This is not a strict partition of the input set because different people may share a surname.
I'll call a name _ambiguous_ when it may legitimately be associated with more than one hypothesis.

## Dialogue

I start with two agents. The first is the **normal** agent that breaks names into tokens on whitespace, removes punctuation characters, and forces the token to lower case.
I expect this to make good matches but leave a lot of equivalent names unmatched.
The seconds is the **initials** agent that replaces all but the last token of a name with its first letter.
It will make more matches but some of them will be false.

I make a "top attributes are people" assumption in each case (see the [WW1 example](https://knoxa.github.io/examples/names/) discussion) to recover [normal hypotheses](hypotheses/normal.xml) and [initials hypotheses](hypotheses/inititals.xml).
Each `object` in these files represents a person, and each `attribute` a name associated with that person.

I can compare these hypotheses by merging the two files (a disjoint union of the objects) and applying FCA:

![normal and initials hypotheses - differences](results/NI-hypotheses.svg)

Agreement between the two agents is indicated by an object from each occupying the same concept node.
This is most obvious in the disconnected concept nodes at the bottom of the diagram.
The graph clusters above represent disagreement between the agents.
I want to resolve these disagreements.

## Preference

In general, I prefer the results of **initials** to **normal** because they are more likely to be complete.
In the lattice, objects with larger sets of attributes appear below objects with a subset of their attributes.
I could, naively, take any object that appears at the bottom of the lattice (no incoming arrows) and give it all of the attributes above.
This is reasonable, but carries over some errors that I can address at this point through a more careful analysis of the lattice.

### Complex names

The **initials** agent deals well with name abbreviations and initials.
It falls down when the name has a suffix (so the surname isn't the last token) or when the name is expressed with the surname first.
The result is that it will fail to match names that it would otherwise match if it could parse the name and work out which token was the surname.
I'm happy to ignore this weakness for the time being. Some of these names will be matched by **normal**, which ignores token ordering.
The result is the large cluster of nodes (in the second "row" of the diagram) relating to William Augustus Prevost and William Keppel.

What does concern me at this stage is the link between these two people.
Because **initials** agent has no notion of suffixes, the last letter of a suffix is interpreted as a surname.
This means that "Sir W. Aug. Prevost, K.C.B." becomes `s w a p k c b`, and "Sir William Keppel, K.B." becomes `s w k k b`.
The tokens of the latter are a subset of the token of the former, so the two names get linked.
"William Keppel, K.B." is linked to "Sir W. Aug. Prevost, K.C.B." in the same way.

I can make a **name-check** hypotheses that expresses this. I claim:

	"Sir W. Aug. Prevost, K.C.B." is not the same person as "Sir William Keppel, K.B." or "William Keppel, K.B.".

Ignoring the logic expressed in the sentence, this simply translates into a hypothesis that is a set of three names.
This hypothesis is explicitly incorrect, but it serves as a marker, allowing any **initials** claims that are a superset of it to be discovered and rebutted.

### Ambiguous names

Some of the names in the input data are just surnames.
These are genuinely ambiguous when there is more than one person with the same surname.
In such cases, I want the name added to all sets of names that have the same surname.

A complication is that there are name tokens in the dataset that are surnames for some people and given names for others, for example "Francis".
The **normal** agent doesn't take account of token order, so will add a lone surname to any sets that happen to have the same token as either given name or surname.
The **initials** agent does take account of order in that the last token is treated differently from the rest.
A lone surname will only get added to a set of names by **initials** if it matches the last token of the name.

The bottom line is that when **normal** and **initials** clash in this way, I prefer the **initials** hypothesis.
My preferred hypothesis is a strict subset of the rejected hypothesis. For example I want {Francis Cooper, Cooper} and not {Francis, Francis Cooper, Cooper}.
This means that the object for the preferred hypotheses appears above the object for the rejected hypothesis in the diagram.
I can take this account when recovering results from this lattice.

### Same surname and initials

There are straightforward cases where two people have the same surname and initials, but different given name.
I can make some more **name-check** claims:

	"John Wilson" is not the same person as "James Wilson".
	"John Dwyer" is not the same person as "James Dwyer".
	"John Cassidy" is not the same person as "James Cassidy".
	"John Ellis"  is not the same person as "Jospeh Ellis".
	"John Hanna"  is not the same person as "Jospeh Hanna".
	"John Chambers"  is not the same person as "[Serj.] James Chambers".

I can even express uncertainty this way:

	Is "Max Watts" the same person as "Mark Watts"?
	Is "Henry Walker" the same person as "Harry Walker"?

These **uncertain** claims generate hypotheses that may or may not be consistent.
They may be accepted or rejected in follow-on processing according to preference.
I'll ignore them here.

### Consistency

At this stage, I want to derive a consistent set of hypotheses from the combined results of **normal** and **initials**.

To make it easier to follow what's going on, I'll start by filtering out the agreement between the two agents.
I do this by finding concept nodes in the lattice that have an object from each each.
I make a new object that has all the attributes in this node's extent.

I can check the [normal-initials agreement](hypotheses/ni-agree.xml) using FCA.
I get discrete concept nodes except where different people have the same surname.
These surnames are legitimately ambiguous. It's simple to recover them from this lattice.

Next, I process the disagreement, with my [corrections](hypotheses/correction.xml) thrown into the mix.
I [edit](editing.md) the resulting FCA lattice to action the corrections and form a new set of hypotheses from the results. 

I can use FCA again to assess these new hypotheses.
I get more singleton concepts indicating agreement.
I also get a number of clusters, with two or more concepts feeding into a single concept, where the top concept represents an ambiguous name.
The remaining four clusters are more complex. The simplest two suggest more decisions to make about ambiguity.
They go away if I say:

	"Charles Moore" is not the same person as "Charles Moore Harrison".
	"William Thomas" is not the same person as "William Thomas Tayler".

The remaining two clusters are for William Augustus Prevost and William Keppel, now separated from each other.
The extra structure I see comes from the fact that each of them is represented by multiple consistent hypotheses.
I want to merge these consistent hypotheses to make a single hypothesis each for Keppel and Prevost.
I could get what I want to be by assuming each cluster represents a person with all the attributes as names, but that's difficult to justify as part a multi-agent dialogue.
Instead, I'll add another agent to the dialogue.

### Identity

Within the limitations of **normal** and **initial**, I assume that all the hypotheses so far are consistent.
I can assign a consistent hypothesis an identifier based on the set of names in the hypotheses.
If I deem two hypotheses to be about the same person, I can assign the same identifier.
I can make this identifier a new attribute on any hypotheses that I identify.

Let's imagine a personalities database and a process that will take the set of names in a hypothesis and search the database for a match.
What'll I'll actually do is add 'PREVOST' as an attribute to any hypothesis that mention Prevost, and a 'KEPPEL' attribute for Keppel.

Now, If I apply FCA, I get 'PREVOST' and 'KEPPEL' concepts at the top of their respective clusters.
I can use the "top concepts are people" assumption to get the [merged hypotheses](hypotheses/ni-consensus.xml) I want.

## More agents

I now have consistent sets that represent the merged views of **normal** and **initials**.
Transcription errors in surnames will not picked up by these agents, so I turn to a **soundex** agent that converts names to token in the same way as **normal**,
but then translates each token to its Soundex code. Objects are Soundex codes, and attributes are names.
This is a generalization of **normal**, which means that names deemed equivalent by **normal** will be subsets of those deemed equivalent by **soundex**.

I can merge [soundex hypotheses](hypotheses/soundex.xml) with [the consensus](hypotheses/ni-consensus.xml) so far, and apply FCA to compare.
A **soundex** hypothesis appears in the lattice below two or more consensus hypotheses where **soundex** is suggesting a new association between names.
Most of these new associations will be correct, but many won't.
I can either be discriminating when assessing **soundex** hypotheses, or I can simply accept them for the time being and try and weed out the inconsistent hypotheses later.
I'll set this aside for the moment and address a simpler case that finds new associations.

A feature of the dataset is that the typeface used in the source text makes it difficult to distinguish "f" from "s".
I can introduce a **long-s** agent that uses the same tokenization as **normal** with the exception that "f" and "s" are changed to '\*'.
I get a set of [long-s hypotheses](hypotheses/long-s.xml).

Like **soundex**, **long-s** is a generalization of **normal**.
In cases where two or more **normal** hypotheses are strict subsets of a **long-s** hypothesis, the **long-s** hypothesis represents names that are equivalent (if you ignore the long S). I'm happy that these hypotheses are all consistent.
The circumstances are similar to those for **soundex** with the exception that I can safely take the simple option of preferring **long-s** objects.
I get [a new consensus](hypotheses/lni-consensus.xml) between **long-s**, **normal** and **initials**.

Going back to **soundex**, I'll try a slight different approach.
Instead of trying to merge these new results directly with the consensus, I'll extract **soundex** hypotheses that clash with the **normal** and **initials** consensus.
I just want hypotheses that give new combinations of names, so I ignore any **soundex** objects that appear above a consensus object.

I can then compare these [new soundex](hypotheses/soundex-new) hypotheses with [the consensus](hypotheses/lni-consensus.xml) between **long-s**, **normal** and **initials**.
There are patterns in the resulting concept clusters that I need to assess.
In lots of cases, I have a cluster consisting of a single **soundex** object point upwards to two or more consensus objects.
If **soundex** has made a sensible match, I can just pull all the attributes together into a single hypothesis.
I need to check each case though, because **soundex** might make matches I don't like. For example, it equates "Stevens" and "Stepney".
Another pattern is a concept node that is pointed to by both a **soundex** object and a consensus object.
In this case, again subject to checking, I should add all attributes of the **soundex** object to the consensus hypothesis.

Coming up with preference rules to create these new hypotheses is straightforward enough, but checking that the quality of the match is acceptable is strictly a matter of judgement as things stand. 
There are few enough cases that I can do this final step by hand for the moment, and come back to the quality checking problem later.

The result is this set of [officers of the 67th Foot](results/latest-67.xml).
Similarly, I've derived [officers of the 37th Foot](results/latest-37.xml).

These results aren't perfect. I can immediately spot a couple more transliteration issues that haven't been picked up yet.
As assertions, these are:

	"James Biair" is the same person as "James Blair".
	"JohnGelling" is the same person as "John Gelling".

## The story so far

I have agents that make claims that names do or don't belong to the same person.
I compare and contrast these claims to find consensus.

The quality of the result depends on the capabilities of these agents and how differences between them are resolved.
Above, I've tended to try and find consensus between a pair of agents before bringing in the opinions of a third.
I've done this in an iterative fashion that is easier to understand and explain the process. 
I need to consider alternative approaches:

* Can I merge hypotheses from all agents and find consensus in a single step?
* Can I have agents that operate on just a subset of the input? Agents that "know" a particular family perhaps.
* I posited an **identity** agent above. What role should this have in entity linking? What role should entity linking have in entity identification?

## To do

The mismatches produced by **soundex** show that I need to add critical agents that can check the quality of claims made by others.

Resolving differences between agents amount to defining preferences and enacting them through operations on an FCA lattice.
I need to formalise this process.



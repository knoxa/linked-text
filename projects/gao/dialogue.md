# Georgian Army Officers

Linking records for the 67th Regiment of Foot in [Georgian Army Officers database](https://www.georgianarmyofficers.org/) that relate to the same officer.

## Input

I downloaded the [dataset](https://www.dhi.ac.uk/data/britisharmyofficers) and filtered for "67th Foot" in the `reg_regiment` field.
I took distinct values from the `name` field and make a [list of names](input/names-67.txt). There are 894 of them.
A couple of the names include strange non-display characters.
I've left these alone because I'll want to use these names to link my disambiguation results back to the original records.

## Method

I apply the same [FCA](https://en.wikipedia.org/wiki/Formal_concept_analysis) method discussed in some detail in the context of a [WW1 example](https://knoxa.github.io/examples/names/).

The method operates on tokenized names to produces sets of names deemed equivalent through sharing common tokens.
The method is agnostic to the algorithm used for producing tokens from names, but the algorithm will affect the specificity of the results.
For example, simply splitting the names into word tokens is less likely to put together two names that are from different people, but more likely to consider different expressions of a name as belonging to two different people.
Methods that generalise the tokens, such as Soundex, do the opposite.

An advantage of the method is that the output from any single choice of tokenization algorithm can be considered as a set of hypotheses.
Each hypothesis is a set of names (as they appear in the input data) that are deemed to be equivalent.
Different tokenization choices produce different results, but they can be compared. I use FCA again to compare hypotheses.

The output from FCA is a [lattice](https://en.wikipedia.org/wiki/Lattice_%28order%29) that can be represented as a graph and visualized.
A nice side effect of the method is that similar names will appear close to each other in the visualization.
This affords the opportunity to notice matches not found directly by the algorithm and manually assert them.
Such assertions can be considered as 'expert' hypotheses and given added weight when comparing them to hypotheses produced directly by a tokenization algorithm.

The process is naturally iterative. Each round of generating hypotheses suggests alternative tokenizations that might be applied on the next iteration.

One approach here is to start each iteration with accepted hypotheses generated from the previous one.
Instead of creating a set of token from one name, I can create a set of tokens from multiple equivalent names.
This addresses issues like initials and name abbreviation in some expressions. Once an example is included in the set of equivalent names, I end up with an association between (say) initial and forename.

For the sake of discussion, I consider each variation in (tokenization) parameters as being from a different agent.
A human expert making assertions is also an agent.
I can then present what follows as a multi-agent dialogue that aims to agree on a final result.

## Multi-agent dialogue

I start with two agents. The first is a 'normal' agent (N) that breaks names into tokens on whitespace, removes punctuation characters, and forces the token to lower case.
The seconds is a 'soundex' agent (S) that takes the normal tokens and converts them to their equivalent Soundex codes.
I make a "top attributes are people" assumption in each case (see the [WW1 example](https://knoxa.github.io/examples/names/) discussion) and compare the hypotheses:

![Normal and Soundex hypotheses](results/NS-hypotheses.jpg)

The disconnected concept nodes at the bottom of the diagram represent agreement between the two agents. Differences of opinion appear as graph clusters above.
Ignoring agreement for the moment, here are the differences as an SVG image:

![Normal and Soundex hypotheses - differences](results/NS-hypotheses.svg)

In this lattice, an object represents a person and its attributes are names.
The attribute labels are visible in the diagram. The object labels aren't immediately visible, but you'll see them if you download the SVG, display it in a web browser, and "mouseover" the concept nodes. Each object label starts with either "S" or "N" according to which agent is asserting that the object represents a person.

To recover a person from this lattice, you find a node that has an object (person) attached, and give it any names you can reach by following the arrows "upwards".
I can decide between between the two agents and action that decision by removing object references from the lattice. For example, here ...

![Soundex covers Normal](results/NS-diff.svg)

... there is a single Soundex object at node 140 hypothesizing one person with all 7 names.
The Normal agent produces 7 objects, one at each of the remaining nodes, hypothesizing 7 different people with 7 different names.
If I delete the Normal object references, then recover any remaining objects and their attributes, I get just the correct (Soundex) hypothesis.
I can make similar judgements all over the lattice diagram and recover "truth". See the [WW1 example](https://knoxa.github.io/examples/names/) for more detail on this.

I can also introduce more agents into the dialogue. For example, a "Long S" (L) agent that uses the same tokenization as the Normal agent with the exception that "s" and "f" are changed to "*". This is a generalization of the N-agent, which means that names deemed equivalent by the N-agent will be subsets of those deemed equivalent the L-agent.
I for cases where an N-agent hypothesis is a strict subset of the L-agent hypothesis, so the L-agent object that represents two names that are equivalent (if you ignore the long S) is below the two corresponding N-agent objects in the lattice. I get a set of [long-S hypotheses](hypotheses/long-s/xml).
I'm happy that these hypotheses are true in the sense that equated names really are equivalent, but the person represented by the set has other names too.
I'll say these hypotheses are consistent but not complete. In any further argument I can say that sets containing either can be merged.

I can do something similar with an Initials (I) agent that replaces all but the last token of a name with its first letter.
This time names are equated when they shouldn't be, "John Wilson" and "James Wilson" for example. These hypotheses are neither consistent or complete.
I need to make some corrections before I can usefully use these hypotheses in furth arguments.


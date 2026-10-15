# Georgian Army Officers

Linking records for the 67th Regiment of Foot in [Georgian Army Officers database](https://www.georgianarmyofficers.org/) that relate to the same officer.

## Input

I downloaded the [dataset](https://www.dhi.ac.uk/data/britisharmyofficers) and filtered for "67th Foot" in the `reg_regiment` field.
I took distinct values from the `name` field and make a [list of names](input/names-67.txt). There are 894 of them.
A couple of the names include strange non-display characters.
I've left these alone because I'll want to use these names to link my disambiguation results back to the original records.

## Method

I apply the same [FCA](https://en.wikipedia.org/wiki/Formal_concept_analysis) method discussed in some detail in the context of a [WW1 example](../disambiguate-person/README.md).

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
I can then present the iterative process of extracting equivalent names as a [multi-agent dialogue](dialogue.md) that aims to agree on a final result.

# Formations

I want to understand the assignment of Hampshire Regiment battalions to military formations over time. 
The [formations.xhtml](https://tigersmuseum.github.io/history/units/formation.xhtml) page captures facts about deployment of units that pertain at particular instants in time, or during specified time intervals.
The aim is then to piece these facts together to give a coherent picture, and to get a better idea where there are gaps in knowledge.
I'll try and use this information to build *timelines*.

The exercise requires modelling states that change over time. Ideally, I'd have a contiguous series of states with specific dates.
Full knowledge would tell me the exact composition of formations at any time.
In practice, I might know that a state existed at some time, but not when it began or ended; or only when it began, or when it ended; or perhaps only that it was after or before some other state.
I need to capture this partial, and often vague, information as best I can.

## As linked data

A relationship between entities that exists only for a specific time is a **state**.
I can model military formations as a series of states:

An [IES](https://github.com/dstl/IES4) `State` is an OWL Time `Interval`.
The relationship between a unit and a larger formation is `ies:isPartof`.
States in IES work by creating a `State` object that is `ies:stateOf` of one of the entities in the relationship, then substituting this for the
subject or object of the relationship triple. For example:

	1st Battalion, Hampshire Regiment, was assigned to 11th Brigade throughout the First World War.

This is a state `ies:stateOf` "1st Battalion", with the state `ies:isPartof` "11th Brigade".
It could equally well be modelled as a state that is `ies:stateOf` "11th Brigade", with "1st Battalion" `ies:isPartof` the state.
Either way, it's the state that is associated with the instant or interval of time.
This example gives a duration by reference to a well known interval, the First World War.
The [intervals.xhtml](https://tigersmuseum.github.io/history/events/intervals.xhtml) page include RDfa that makes the start and end of such intervals explicit.
I set the the interval for this state to be `time:intervalEquals` to the First World War interval defined there.

There's a lot of variation in how time is expressed in natural language.
Again, there are modelling choices in how best capture those expression as (OWL Time) linked data.
Some examples are below.

	2/5th Battalion, Hampshire Regiment, was assigned to 232nd Brigade from April 1917 to the end of the First World War.

The interval begins at an instant somewhere a particular month, so I use `time:hasBeginning`, specifying an `Instant` that is `time:inXSDMonth` April 1917.
The end of the interval isn't given directly, it's given in relation to a well known interval.
I use `time:intervalFinishes` to say this state ends at the end of the First World War, but starts after the beginning of the war.

	122nd Brigade was part of 41st Division during the First World War.
	
I use `time:intervalDuring` to say the state is valid during some part of the First World War, but not all of the First World War. Note that `time:intervalDuring` implies after the beginning and before the end of the war. If I want to fix one end of the interval at the start or end of the war I could use `time:intervalStartedBy` or `time:intervalFinishedBy` instead.

	41st Division was part of X Corps in 1917.
	41st Division was part of XVII Corps in 1917.

I use `time:inside` in cases where I know a state is valid at a particular instant somewhere inside an interval. Here I have two different states of the same entity, both are which are valid at different instants that are both `time:inXSDYear` 1917. If I know which of these states came first I could relate one to  the other by `time:intervalBefore` or `time:intervalAfter`.

	The 2nd, 1/4th and 5th battalions were part of 128th Brigade in in March 1944.
	
I might model this as a separate state for each of the battalions, or one state of the brigade. In the former case, I have 3 states that are `ies:stateOf` a battalion and `ies:isPartof` a brigade. In the latter case, the state is `ies:stateOf` a brigade, and each battalion is `ies:isPartof` the state.
In this instance, it's less work to create one state rather than three, so that's what I do.

## Timelines

States can be ordered in time. States are related if they about the same entity. The change of state of an entity over time is a *timeline*.
I can construct a history of an entity by piecing together its timeline.
I don't expect to ever have complete information, so the history will likely be fragmentary.

The primary evidence for a history is a number of snapshots that need to be ordered in time and related by common actor. The common actor is the entity, and each piece of evidence describes a state of that entity at a particular instant. A state is a set of relations, between the target entity and others, that are true at that time. If two states close in time describe the same relations, then I assume that the state applies for the interval between them.

I collect the set of states that are explicitly about a military unit of interest, and also consider any states of units for which it is a constituent part. I order these in time. This gives a structure that can be tested for consistency, looking for corroboration and contradiction. I can make inferences to simplify and summarise the structure.

## Simplifying

This gets too complicated to capture directly as RDFa mark-up of XHTML. It quickly becomes easier to adopt some mark-up conventions and then post-process to
generate the rest of the structure. I do these things:

* Enclose entities in HTML `span` entities.
* Add a `class` attribute to HTML span to indicate entity type.
* Add a `typeof` attribute to HTML span to specify entity type.
* Add an `about` attribute to HTML span to specify identity.
* Add one of: `rdfs:label`, `skos:altLabel` or `skos:prefLabel` as the value of a `property` attribute to HTML spans to specify an entity name.

It's useful to be able to identify a claim as well as parse it.
I might assume all text in the document is claims, or it might be useful to include comments that are not a part of claim.
In the latter case I can include HTML `class` attributes to distinguish claims from comments.

## Information extraction

I use the [eleatics RDFa extractor](https://github.com/knoxa/eleatics/blob/master/xsl-utils/rdfa-ntriples.xsl) to extract RDF triples from the XHTML.
I extend these triples with custom XSLT transformations that are directed by semantic mark-up.

Over and above semantic mark-up, I rely on NLP for fact extraction.
I consider the NLP processing in two steps: Find entities first, then find relationships between them.
The first step requires constructing a dictionary of entity names that capture any mention of an entity in the text.
I make this easier by constructing a reference document of [named units](../units/units.xhtml) that is full marked up with RDFa.
This generates a dictionary of both alternate and preferred names that can be used to identify entities by URI.

If a mention of a name in the text is ambiguous, then it can be made explicit (without necessarily changing the text as displayed) by adding a @content attribute to the `span` delimiting the mention.

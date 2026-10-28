# Results

The direct result of the entity linking method is this set of [officers of the 67th Foot](latest-67.xml).
I've also done something similar [officers of the 37th Foot](latest-37.xml).

Each of these files describes a [formal context](https://en.wikipedia.org/wiki/Formal_concept_analysis#Formal_contexts_and_concepts).
The set of attributes is the [set of names](../input/names-67.txt) in the input file.
Each `object` element represents an object, and the relation between objects and attributes is expressed by nesting `attribute` elements inside `object` elements.
Two `attribute` elements with identical content represent the same attribute.

I want to use these results to group records from the input dataset by person.
To that end, I've made an XML version of the 37th Foot and 67th Foot subset of records.
This has a `row` element per row, and a `col` element for each field within the row.
Every `col` element has a `name` attribute set to the value of the column name (as expressed in the first row of rows.csv) and a `value` attribute that is the value of the field.

The XSL transform in [group.xsl](../xsl/group.xsl) takes one of the results file as input and the corresponding row data XML file as a parameter. 
For each `object` (person) in the input, it make a `person` element and copies into it any rows where the "name" column matches any of the attributes.
See the **group-rows** target in [build.xml](../build.xml).

For records that have been grouped by person, I can apply [make-sortable.xsl](../xsl/make-sortable.xsl) and [sort.xsl](../xsl/sort.xsl) to add a name as a `sort` attribute to the `person` element, and sort by it.


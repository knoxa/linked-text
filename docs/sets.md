# Arguing with sets

I want to assert an identity as a set of attributes.

Some attributes may have a unique value. I'll call these _identifiers_.
Other attributes represent properties that are common to many 

An identifier may have a indirect relationship with the entity. For example, each record in the GAO database has an identifier for the row.
The row is data about a specific officer, so the row identifier is arguably an identifier for the officer.
The problem here is that the association between row and officer is not explicit.
Any process of making the association is subject to errors.
Any row should be assigned to exactly officer.


I represent a notional entity as a set of attributes.
An entity may have many identifiers, but no identifier belongs to more than one entity.

If the sets consist solely of identifiers, then I expect them to be discrete.
In other words, there should be no attributes in common between any pair of entities.

If the sets intersect there are these possibilities:

* The two sets identify the same entity. I can merge the sets.
* The two sets identify different entities, 

A subset is consistent with its superset.
Superset supports subset.

I want an identifier for the entity, but I don't want the burden of master data management.
I can use globally unique identifiers that others have coined if I can find them.
I can use a name as though it were an identifier.


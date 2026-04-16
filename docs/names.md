# NER

## People

- *LoadTextDatabase* - Read XHTML file. Treat HTML articles in XHTML files as documents: Find articles with Xpath.
Parse, with article node as parent, using *HtmlParser*. Save the Html structure and attributes to an Html database with some identifier.
Save the text content to a Text Database with the same identifier.

NLP operates on the Text database.

- Shallow parse Text database - Operate on text strings covered by HTML paragraph elements: Sentence splitting, tokenization and POS tagging.


- Annotate text - Database matching: For names of people, for names of civilians (so names that aren't of interest can be found and removed from further consideration).
For ranks and titles.
Regular expression matching: For service numbers. Optionally, noun phrase chunking.


- Modify annotations - SQL utilities to clean up overlapping annotations, remove civilians.


- Query to select documents from database, then serialize to Baleen XML. Can use XSLT-Parsers to perform NLP on this XML.


### Building dictionaries

For a historical text, I want a list of all mentions of names within the text. I get this by iteration.
I can start with a seed dictionary of ranks and titles, a dictionary of suffixes, perhaps a few common forenames or surnames.
I shallow parse to create noun phrases and apply the dictionaries. Perhaps also regular expression matching for service numbers.
I select unique noun phrases that contain dictionary terms, and make this the basis of a Names dictionary.
I can use NLP to apply rules in making this selection if I want. For example, I might select all noun phrases that start with a rank.
I can iterate this process, making changes to the seed dictionaries as I go, and collecting more names in the Names dictionary.
At some point, I can switch to applying just the names dictionary.
I can serialize the results as HTML, marking up names in the output, and scan the results to assess quality. (xsl/html-new.xsl)
I can then add or remove entries as I see fit.

## Names dictionary

This is simply a list of mentions of person name.
In context they are mentions of people, but out of context there is no way of knowing if an entry in the dictionary refers to one individual or several. 
An individual may be referred to by many entries in the dictionary.
Applying the dictionary to text gives context to the mentions.

# Notes on conversion

*From a Project Gutenberg e-text to a usable markdown file, with the help of regular-expression (regex) search-and-replace*


**Removing all the line-breaks**; Project Gutenberg texts, for historical reasons, are all line-broken at 78 characters or less. It would be nicer to have a more modern system, where a paragraph makes a single 'line' with the LF at the end.

Note that we don't *have to* do this; Pandoc will parse it with the line-breaks in. But if we fix this, it will make further editing easier (trust me).

A simple regex to remove linebreaks, leaving us with regular paragraphs.

    search: (\S)\n
    replace: \1_

But you have to do it bit by bit, because there are probably sections in which you want to keep the linebreaks -- like poetry!


    search: (\S)\n([^ ]) 
    replace: \1 \2

 is better, but if any poetry is flush-left, it will unbreak thost lines. which is what we 

 So for a complex text like *Alice* we have to do the search-and-replace in sections (with the little "in selection" box ticked). For a less complex text, you might be able to do it with a single global replace.

AND THEN, as a side-effect, we lost the blank lines separating our 'paragraphs'. easily fixed:

    search: \n
    replace: \n\n

Markdown doesn't care if there are multiple blank lines (or, for that matter, multiple spaces); it (same as in any XML-based language) collapses multiple spaces or lines to a single space or line.

 ---


Easy fix to **move the lengthy Project Gutenberg frontmatter** and put it at the end, with an H1 that sets it as a chapter-like object.

---

**Table of contents** can be removed, as Pandoc will build us a nice linked one automatically.

----

**Chapter heads:**

	CHAPTER I.
	Down the Rabbit-Hole

can be normalized:

	search: CHAPTER ([IVXCLD]+)\.\n(.*)
	replace: # Chapter \1:

or, if we've removed the linebreak already:

	search: CHAPTER ([IVXCLD]+)\. (.*)

---

We could (we technically don't have to, because pandoc will still recognie them) **change the _italics_ to *italics*:**

	search _(.+?)_
	replace: *\1*

---

Fix those big ugly three line **section breaks** by:

- turn off the regex mode, so that we're doing a literal search
- copy the three lines
- paste into the search box
- replace with "---" 

`---` makes a horizontal line, but we could style it as anything we like in the output.

---

**Poems** and other things where we *do* want the linebreaks (and manual indents) to matter:

Precede these with a | and a space, like

| “How doth the little crocodile
|     Improve his shining tail,
| And pour the waters of the Nile
|     On every golden scale!

Possibly easiest to edit manually, but a regex for this might be:

	search: (.+)
	replace: | \1

again... do this with the "in selection" box checked

---

**Metadata**

At the very top of the file, we have  a block like this:

	---
	title: "Alice’s Adventures in Wonderland"
	author:  Lewis Carroll
	edition: "THE MILLENNIUM FULCRUM EDITION 3.0"
	date: July 2026
	---

We can put more of that in, as an ebook reader will pick up a lot of it.

---

**Images**

	![This will be the caption](folder/filename.jpg "This will be the alt-text")

The `folder/` part of the filename has to lead to where the ebook will find the image files.

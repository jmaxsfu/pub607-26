LOG

# 1) Get all the content

"Select All" and "Copy" entire contents, paste into crane.md text file.

# 2) Remove page footers, replace with a • to mark individual pages

Regex search and replace:

	(.*) 2024.9.1(.*)indd(.*)
	\n•\n

# 3) Clean up page numbers

Put page number with the •

	•\n\n(\d+)
	•\1\n

This caught all the page numbers up to teh end of the table of contents. And then subsequently only some. 53 in total.

# 4) Clean up column breaks, keep a marker §

   ^2024\/9\/1.*
   \n§\n

# 5) Edited frontmatter

Manually added # to mark headers in frontmatter

Manually broke paragraphs (the copy-paste meant paragraphs were all together)

Re-spliced the lines of each paragraph into single line-paragraphs with search and replace:


Noticed that I've lost the italics when I copy-and-pasted the content... no way around this with a PDF as source.

# 6) Moved frontmatter into clean markdown file on is own:

1.frontmatter.md

Removed page numbers and ensured that paragraphs were complete.

# 7) Section Head Pages

Each has an image

Chinese heading has a two-line character:

篇
一

Means "chapter 1"

I think I will remove "篇" and leave the number. We can add that character later in styling.

Trying this as a bilingual heading:

	## 一 诗应当不言 / 而自明 \ I.  A poem should not mean / but being.

Removed the  in this first section head

This might need to be revisited later.


# 8) Broke out the Acknowledgements and Bibliography to a new file, 3.backmatter.md

Removed page numbers and ensured that paragraphs were complete.

Manually fixed list in the Acknowledgments

Manually fixed the Bibliography (no italics still)

Manually fixed the Chinese parts at the end, probably wrong!

# 9) New file 2.Poems.md

# 10) Made H2s from English poem titles:

	•\n\n([A-Z]+)(.*)
	## \1\2\n

Manually fixed those titles that were in two lines, simply by joing them back up

Manually fixed some lines at the top of pages that this replacement caught by mistake

Noted that the poems on page 15, 18, 25, and many more were somehow built (laid out) differently -- the two headings together, apart from the verse. Different from all the rest. Why? **These need to be corrected** You'll see them because they have two headings (one Chinese, one English), right after one another.

# 11) The same but in Chinese!

The same attempt to do H2s, but I don't know what I'm reading!

	[•§]\n\n(.+)
	## \1\2\n

This time instead of "replace all" I went through and looked at each one before I pressed "replace"


# 12) Editing poetry!

Put in ### third-level heads for numbers in long poem "CREED"

# 13) Adding document structure

IN order to have the two languages facing, we need to identify the parts, and how they relate to each. So I set in three sets of labels:

:::{.pair}

:::{.poem .chinese}

:::{.poem .english}

This results in the following HTML for each pair of poems:

<div class="pair">
	<section class="poem chinese">
		<h2> ... </h2>
			...
  </section>
	<section class="poem english">
		<h2> ... </h2>
			...
  </section>
</div>

(the same markdown ::: becomes a div when there is no heading, and becomes a section when there is a heading -- the heading provides the sections "id". A div is anonymous.)

Then in the CSS, we say

div.pair {
  columns: 2;
  break-before: always;
}

That makes the pair into a thing with 2 columns, and that should always begin on a new page. Then within that, we ask that we don't break to a new column within the poem.

section.poem {
		break-inside: avoid;
}

It works in HTML (in web browser, except there are no pages there). It works in Thorium Reader (EPUB, with pages, and with a variable width screen). It does not work in the ereader app on my phone; here it makes each poem (a single column) into each page.

# 14) Images

I added the line-art images from the Chapter starts, and attempted to position the images properly with respect to the heading text. 

Here it might be possible to do this on a web page, but the constraints of an e-reader app or device make it very tricky to do this positioning. An alterntive might be to create a single image that contains the text of the title as well -- and then to make the actual first-level heading (which gets used to ebook navigation) inconspicuous.










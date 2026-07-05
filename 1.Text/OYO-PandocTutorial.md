# A Pandoc Tutorial


One of the key pieces of software we will use with markdown is **Pandoc** -- which bills itself as the "universal document converter." 

<https://pandoc.org>

Pandoc is not the only tool that will convert markdown -- indeed there are hundreds of those -- but it is the best, and the most flexible.

Pandoc was originally designed as a markdown-to-HTML conversion tool, but it has been *generalized* to work with dozens of different input and output formats.

What that means is that it takes any structured (or even semi-structured) document format, and parses it into an internal representation. That internal representation can then be re-written in any other structured document format.

Pandoc is extremely high-quality software, and it is *exquisitely* well documented. I have often said that "a close reading of the Pandoc user manual would constitute a whole course in document production." Since you are currently taking a course in ebook production, it would be a good idea to at least familiarize yourself with Pandoc's incredibly well-written User's Manual: 

<https://pandoc.org/MANUAL.html>



## Working with Pandoc


We talk to Pandoc by issuing commands in our command shell. The examples below assume you are "in" the same folder where the files are. If not, you need to `cd` into that folder, so that when you `ls` to see the files there, you see the ones you want to work with. 

The basic format for Pandoc commands is like so:

    pandoc inputFile -o outputFile 

There are other options we can (and will) specify, though, by writing them in the age-old Unix way, with a hyphen and a letter, like "-o" above. 

(Pandoc also has more verbose, explicit alternatives where you type two hyphens and then a specific label, followed by the equal sign, and then the option you want. That's harder to describe than it is to show. See below...)

In the examples below, I'll show both ways of setting these options... in practice, it's easier to type the shorter version, but the longer version is useful for getting familiar with them.


## Simplest possible Pandoc conversion:

    pandoc  test.md -o test.html  

    pandoc  test.md --output=test.html

These two versions are identical; I'm including both for the sake of clarity, and so you can get used to what the hyphen-flags stand for.

The **-o** part tells Pandoc to put it's *output* ("o" for "output,") into the filename you specify after the -o. If you don't specify and output file, it will spew the output onto your screen, which is probably not what you want. 

If you specify a file that already exists, it will be *over-written*. If you specify a file that doesn't exist, it'll get created.

Open the resulting file up in your web browser -- and in your text editor. Note that this simplest-possible example isn't actually a complete web page -- it's just your content in HTML format. 


## Standalone: -s

To make it into a complete web page, we can ask Pandoc to include a proper HTML header and footer -- make it a "standalone" document.

    pandoc -s test.md -o test.html  

    pandoc --standalone test.md --output=test.html

If you look at that in your browser (and in your text editor), it's a little better. It now has a proper document "head," which specifies the title, and the character set, and things like that. Pandoc also adds a boilerplate stylesheet so it looks a bit more like something.


## Add a stylesheet: -c

Let's add a stylesheet of our own instead of the default one.

    pandoc -s test.md  -o test.html -c stylesheet.css    

    pandoc -s test.md  -o test.html --css=stylesheet.css  

Pandoc is smart enough here to reduce its built-in boilerplate stylesheet to the bare minimum, and link in the one that we told it to use. We could call it "house style" and use it for all our books!


## Pandoc has multiple export formats.

If you don't tell it otherwise, Pandoc tries to guess what formats it is supposed to read from, and write to, by looking at the **filename extensions** on the input file and the output file. But you can be explicit about output formats including html, rtf, odt, epub3, docx, icml, and many more. Use -t (convert "to")

    pandoc -t docx test.md -o test.docx

    pandoc --to=docx test.md -o test.docx


## Pandoc has multiple import formats.

We can convert *from* many different formats as well, making that explicit by using -f (convert "from")

    pandoc -s -f docx test.docx -o test.html  

    pandoc -s --from=docx test.docx -o test.html

You can convert back to markdown, too.

    pandoc -f html -t markdown test.html -o test.md 

    pandoc --from html --to markdown test.html -o test.md

## Thats the basics!

You now know the basics of how to ask Pandoc to do conversions. The Pandoc manual, however, is ~175 pages long. So there is a *lot* of nuance and flexibility on tap. You should spend some time browsing the Manual... https://pandoc.org/MANUAL.html


# Pandoc to EPUB - Building your EBook with Pandoc

If we can create HTML, we're already 90% of the way to EPUB. Not surprisingly, Pandoc can go the extra steps to creating EPUBs, and does a really good, thorough job of it.

The sensible way to proceed is to prepare the content as markdown, and to develop a basic stylesheet while converting to HTML only -- *this allows very easy proofing and feedback in your web browser*. Once you're happy with the editing, then you can shift to producing EPUB, which is more cumbersome to proof.

It's common practice to produce ebooks with one chapter per file. The reasons have to with ease of use, and probably a little bit about keeping the files small and fast to load, too. But you don't have to; you can easily produce an EPUB with all the content in a single text file; 

Pandoc uses the Headings (level 1 or 2, typically) to build the chapter navigation.

So we'll proceed with the idea of an ebook as a folder full of files. This example will have one markdown file per chapter. We can get pandoc to assemble them all, convert to HTML, assemble the package, and set the metadata fields. 

## Simplest possible:

    pandoc chapter1.md chapter2.md chapter3.md  -t epub \
      -o book.epub

You can open this file up in Thorium Reader or Apple Books.app or whatever.

Note that it doesn't need that -s (standalone) flag, because epub is a complete, self-contained file format already.

BTW, the \ at the end of the line is a Unix-ism that says "*keep reading this command on the next line*." Which is to say, you could write all of that on one single line, but I've broken it up to be more readable.

## Add a stylesheet

We can add our house stylesheet just the same as we did with our HTML conversions:

    pandoc  chapter1.md chapter2.md chapter3.md  -t epub \
       -o book.epub  -c stylesheet.css

## Add a cover image:

Our book shows up in the ereader with a blank cover. Let's fix that: 

    pandoc chapter1.md chapter2.md chapter3.md  -t epub  \
       -o book.epub -c stylesheet.css --epub-cover-image=cover.png 


## Add metadata as XML:

Notice that Pandoc has been complaining that our book has no *title*. It's also missing other information, like *author*, *publication date*, and so on.

There are two different ways: One is where metadata is written in Dublin Core XML and stored in an external file. This option probably makes sense if your company already has an ebook workflow and generates metadata as XML

    pandoc chapter1.md chapter2.md chapter3.md  -t epub \
       -o book.epub -c stylesheet.css --epub-cover-image=cover.png \
       --epub-metadata=metadata.xml

## Add metadata in the source (much simpler!)

There is a simpler method, where you add the metadata in the source markdown file as well, in a "metadata block" that comes at the beginning. 

We'll just pass the metadata as another content file, which I'm calling "frontmatter.md". 

    pandoc frontmatter.md chapter1.md chapter2.md chapter3.md \  
    -t epub  -o book.epub \ 
    -c stylesheet.css --epub-cover-image=cover.png 

Note that you could also pass the cover image and the stylesheet in this metadata block -- and it would clean up this Pandoc command a whole bunch!




## Pandoc to Print

Pandoc has a number of paths to PDF... beginning with LaTeX, a venerable computer typesetting system from the 80s/90s which was extremely well optimized for typesetting equations and formulae, and thus became the go-to system for typesetting mathematics and scientific papers. Lots and lots of scientific journals still use LaTeX. Students in math, physics, chem, learn how to do LaTeX... much better at formulae than any DTP tool, certainly historically, possibly still.

Pandoc also has an ICML output, which is the 'story' format for Adobe InDesign. 'Place' the resulting .icml file directly in a blank InDesign template.

In PUB607, we'll use a newer typesetting tool called Typst. You need to have Typst installed on your computer, and to get past the default formatting, we'd also have to develop a Typst stylesheet, which is different from CSS. More on that later.  

For reference, though, the Pandoc command will look something like this:

      pandoc mybookfiles.md \
      --wrap=none \
      --pdf-engine=typst \
      --variable=TypstTemplate.typ  \
      -o mybook.pdf







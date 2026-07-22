// Typst base layout template
// by John Maxwell, jmax@sfu.ca, 
// VERSION as of July, 2026
//
// Assumes Pandoc v3.10; Typst v0.15
//
// This template is for Typst, run from Pandoc
// The assumption is markdown source, with a 
// YAML metadata block (title, author, date...)
//
// Pass the typst 'template' in the doc's YAML, a
// as a local (same dir) file. 
//
// Note that the typst.template is a Pandoc template,
// not a typst template. It contains only conversion stuff.
// One exception: HR handling is hard-coded to a typst line
//
// Usage:
//    pandoc essay.md \
//      -f markdown --wrap=none \
//      -t pdf --pdf-engine=typst \
//      --template=pandoc-typst.template \
//      -o proof.pdf

// Cribbed from Pandoc's typst template:
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}


#let conf(
  title: none, // These first few come through from markdown metadata
  subtitle: none,
  authors: (),
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  margin: (inside: 1.25in, outside: 1.75in, top: 1.25in, bottom: 1.4in),
  paper: "us-letter",
  lang: "en",
  region: "CA",
  font: ("EB Garamond"), 
  fontsize: 13pt,
  lead: 9.5pt, // CORE VERTICAL SPACING VALUE
  mathfont: none,
  codefont: none,
  sectionnumbering: none,
  linkcolor: green,
  citecolor: none,
  filecolor: none,
  pagenumbering: none,
  pagesInFront: 6,  // unnumbered pages before "1"
  doc,
) = {

  let auth = authors.map(author => content-to-string(author.name)).join(", ", last: " & ")

  set document(
    title: title,
    keywords: keywords,
    author: auth,
  )
  set document(
      author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()


  // Page layout defaults, including running head and foot
  //
  set page(
    paper: paper,
    margin: margin,
    columns: cols,
    // Running header, set for recto/verso, R/L:
    //
    header-ascent: 30% + 0pt,
    header: context {
      if (here().page()) > pagesInFront {  // skip first X pages
        if calc.odd(here().page()) { // odd pages
          align(right,smallcaps(all: true)[#title] )
        } else { // even pages
        	// This author bit could be smarter, grabbing lastnames:
          align(left,text(style: "italic")[#auth] )
        }
      }
    },      
    // Running footer, set for recto/verso, R/L:
    //
    footer-descent: 10% + 0pt,
    footer: context {
      if (here().page()) > pagesInFront {  // skip first X pages
	      set text(fontsize)
	      if calc.odd(here().page()) {
	        set align(right)
	        counter(page).display("1") 
	        h(0.5em) 
	      } else {
	        set align(left)
	        counter(page).display( "1") 
	        h(0.5em) 
	      }
      }
    }
  )  // END set page

  // Paragraph defaults
  // fist-line-indent, leading, justify are set below
  //
  set block( spacing: (lead*2) ) // keeps non-paragraphs spaced!
  set par( spacing: lead )

  // Text defaults
  //
  set text(
  	lang: lang, region: region,
    font: font, // see 'conf' above
    size: fontsize, weight: 400,
    costs: (hyphenation: 80%),
    alternates: false,
    discretionary-ligatures: false,
    historical-ligatures: true,
    number-type: "old-style",
    number-width: "proportional"
  )

  // Block quotations
  //
  set quote(block: true)
  show quote: set block(spacing: (lead*2))
  show quote: set pad(x: 1.25em)
  show quote: set par(leading: lead)

  // Code blocks: green monospace
  //
  show raw: set block(inset: (left: 2em, top: 1em, right: 1em, bottom: 1em ))
  show raw: set text(fill: rgb("#116611"), size: 9pt, )

  // Images and figures:
  //
  set image(fit: "contain")
  show image: it => { align(center, it) }
  set figure(gap: 1em, supplement: none, placement: none)
  show figure: set block(below: (lead*2))
  show figure.caption: set block(width: 95%) 
  show figure.caption: set par(justify: false )
  show figure.caption: set text(size: 10pt) 

  // Footnote formatting
  //
  set footnote.entry(indent: 0.5em, gap: 0.6em)
  show footnote.entry: set block(width: 80%)
  show footnote.entry: set par(spacing: 0.5em, justify: false)
  show footnote.entry: set text(size: 9pt,)

  // Table of contents
  //
  show outline.entry: set block(spacing: lead)
  // show outline.entry.where(level: 2): set block(above: 1.2em)



  // Headings -- Generic Treatment
  //
  show heading: set block(spacing: lead*2, width: 90%, sticky: true)
  show heading: set par(justify: false,) 
  show heading: set text(weight: "regular", hyphenate: false)

  // First-level headings
  //
  show heading.where(level: 1): it => align(center)[
    #pagebreak(weak:false, to:"odd") // pagebreak at H1
    #v(lead*1)
    #set text( size: 18pt); #block([ #it.body ]) 
    #v(0em)
    // #colbreak(weak:false) // pagebreak after
  ]

  // Second-level headings
  //
  show heading.where(level: 2): it => align(left)[
    #set text(size: fontsize*1.05, fill: rgb("#000000"))  
    #block([#smallcaps(all:true)[#it.body]]) 
  ]

  // Third-level headings
  //
  show heading.where(level: 3): it => align(left)[
    #set text(size: fontsize, style: "italic")
    #block(it.body) 
  ]  


	// Styling Custom-Labelled Sections
	//

	// Epigraphs (indent relies in blockquote)
	//
	show <epigraph>: set text(style: "italic")
	show <epigraph>: set par(justify: false)
	show <epigraph>: set block(above: 3em, below: 2em, sticky: true) 

	// Verse, using pandoc "line blocks"
	//
	show <verse>: set text(style: "italic")
	show <verse>: set par(justify: false)
	show <verse>: set block(above: 2em, below: 2em) 

  // References -- hanging indents
  //
	show <refs>: set block(above: lead*6, width: 95%)
	show <refs>: set heading(numbering: none)
	show <refs>: set par(
    justify: false,
    spacing: (lead*2), leading: lead*0.8, 
    first-line-indent: 0em, hanging-indent: 2em,
  )



// STYLING SPECIFIC STRINGS OF TEXT
//
show smallcaps: set text(tracking: 0.1em,)
set strong(delta: 200) // use semibold instead of bold

// why this no work:
show link: set text(style: "normal", fill: blue)

show "❦": set text(font: "Cormorant Garamond")
show "❧": set text(font: "Zapf Dingbats")
show "&": set text(font: "Cormorant Garamond", style: "italic", weight: 500, size: 1.0em)
show " – ": [\u{202F}#sym.dash.en\u{202F}] // narrow non-break space, as per Matt Riggott's Flother.is blog post
//show " – ": [\u{2006}#sym.dash.en\u{2006}] // 1/6em spaces

show regex("[XVI][XVI]+"): a =>  smallcaps(lower(a))
show regex("\d+CE"): a =>  smallcaps(lower(a))

// show regex("https?://\S+"): set text(style: "normal", rgb("#22c"))

show "CV": a =>  smallcaps(lower(a))
show "IIIF": a =>  smallcaps(lower(a))
show "INKE": a =>  smallcaps(lower(a))
show "DHSI": a =>  smallcaps(lower(a))
show "SSHRC": a =>  smallcaps(lower(a))
show "CGS": a =>  smallcaps(lower(a))
show "API": a =>  smallcaps(lower(a))
show "XML": a =>  smallcaps(lower(a))
show "DHIL": a =>  smallcaps(lower(a))
show "PDF": a =>  smallcaps(lower(a))
show "INS": a =>  smallcaps(lower(a))
show "MA": a =>  smallcaps(lower(a))
show "WQB": a =>  smallcaps(lower(a))
show "FCAT": a =>  smallcaps(lower(a))
show "UCC": a =>  smallcaps(lower(a))
show "COPE": a =>  smallcaps(lower(a))
show "CISP": a =>  smallcaps(lower(a))



// ===============================================================

  // THIS IS THE TITLE BLOCK
  //

  set par(leading: lead*0.8)
  v(208pt)
  align(center, text(size: 20pt)[#smallcaps(all:true)[#title]])
  v(18pt)
  align(center, text(size: 14pt, style: "italic")[#subtitle])
  v(18pt)
  align(center, text(size: 14pt)[#auth]) 
  v(16pt)
  align(center, text(size: 14pt)[#date])
  //
  if abstract != none {
    block(inset: 2em)[
      #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  // FRONTMATTER PAGES (comment out as needed)
  // 
  pagebreak(to: "odd")
  outline(title: none);  
  pagebreak(weak: true, to: "odd")
  image("lastorialist/AAIW_F.gif", width: 80%)
  pagebreak(weak: true, to: "odd")
  counter(page).update(1) // re-set page numbering


// THIS IS THE ACTUAL BODY:

  set par( //default for the rest of the doc
    leading: lead,
    spacing: lead,
    first-line-indent: 1.25em,
    justify: true, 
    justification-limits: (
      spacing: (min: 60% + 0pt, max: 120% + 0pt), 
      tracking: (min: -0.01em, max: 0.02em)
    )    
  ) 


  doc  // HERE is the actual body content


// COLOPHON at the end

v(0.9fr)
align(center, text(size: 8pt, style: "italic")[Typeset from Markdown with open-source tools Pandoc and Typst.])  



} // end 'let conf'

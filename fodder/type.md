---
title: Typographic Demonstration
lang: en
---

# About EPUB... and Kindle

:::{.epigraph}
Sigh. Let's not talk about the Kindle. – JMax
:::

[Epub]{.upper} (version 3) is the industry/consortium-backed standard file format for ebooks. It is a well-evolved, open file format (based on HTML and CSS in a container) that is supported by all the main ebook systems out there: Kobo and Adobe and Thorium and a lot you've never heard of.


| There was an old man of peru
| Who dreamt he was eating a shoe
| He awoke in the night
| With a terrible fright
| And found it was perfectly true



What about Kindle? The answer, interestingly, is No. Amazon's Kindle does not support EPUB. Amazon, unsurprisingly, does things its own way... see Simon Rowberry's *Four Shades of Gray* for the story here. There have been a bunch of Kindle file formats over the years. Most of them have been fairly close to the EPUB standard of the day -- although Simon Rowberry reports that the newest version deviates completely, eschewing XML-based representation *entirely*.

> So what good is a standard if the largest vendor doesn't support it? Good question. We should think long and hard about that question.

In practice, though, Amazon supports EPUB from publishers. If a publisher provides an EPUB to Kindle, they convert it into whatever format is currently appropriate. So we don't worry *too* much about Amazon's internal standards being different (even if they are), because it's in Amazon's interested to maintain a client-facing interface that doesn't make it hard to deal with them.

## EPUB authoring tools

Because EPUB is a simple, open format, there are loads of tools that can produce it, edit it, and do things with it.

So, you are likely familiar with Adobe InDesign's ability to export to EPUB. There are online services that will convert MS Word files to EPUB. Apple's *Pages* word processor app will export to EPUB directly.

There's a good reason to be wary of all of these, though... recall the simplicity of text files -- *What You See Is All There Is* -- compared with what's going on in DTP and word processor files, which promise *What You See Is What You Get* -- which is simply a lie in the context of markup. That promise sells people, though, especially if you're not really interested in how these things work; you just want to get the books shipped and move on to your next to-do list item.

# Chapter 2, I think.

*What You Get*, when you export from a visual tool, is a *translation* of what you see in the app. It is a translation based on some rules, that, given the many details that go into text and publication design, *may or may not* give you an EPUB that is faithful to what you started with. It'll try to be faithful to all your typographic styling at least, even when that's not necessarily a good idea. E.g. Drop Caps.

The real trouble is you have no way of knowing what InDesign is going to give you because it is a "black box." If you export from InDesign, and then open up the resulting EPUB in, say, Thorium Reader, chances are you'll see some things that look right, and you see some things that look wrong. But **why** do they look wrong? It's not always easy to tell.
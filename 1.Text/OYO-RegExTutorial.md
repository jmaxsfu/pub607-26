# About 'Regular Expression' parsing

Regular expressions refers to a tiny formal language for **describing** and then acting on (searching, replacing, etc.) regular patterns in text. It is the basis for all sorts of machine parsing of text.

aka "RegEx" or "regex," variously pronounced.

*aka* "Grep" after the venerable Unix tool (**G**lobal **R**egular **E**xpression and **P**rint). Technically, `grep` is an application that uses regex. Since 2003 the OED has recognized "grep" as both a noun and a verb.

"Wildcards" (in Word, for example) are a *similar* thing, but different; tends to be ad-hoc, as opposed to the formal and complete standard that regex is.

*Regular Expressions* date back to the early *Unix* operating system at Bell Labs, circa 1971 or so. The abstract idea is older, but Unix gave us the system in use today.


## Where will you find regex?

Most importantly for us, in **text editors**. But regex is in lots of other software, including:

-   the Unix shell 
-   OpenOffice/LibreOffice suite
-   Google Docs
-   Adobe Creative Suite, and Affinity Suite
-   any decent Text Editor
-   most every contemporary programming language/environment


The "wildcard" search/replace feature in MS Word and Excel is *kinda/sorta* regex. It isn't standard (all the ones listed above are standardized, so if you learn it in one place, it works the same elsewhere), and the syntax in Word isn't the same, but it's kinda/sorta... another good reason to stop using Word.


## Basic concepts

A "regular expression" represents a *pattern* in text, codified in a tiny formal language.

The simplest kind of pattern is a *string* -- just a literal sequence of characters, like a word or a sentence, or a phone number. If we search for "banana" in a text, we will find instances of those six letters together.

But we can imagine other kinds of regular patterns that are more interesting and/or useful to us in our work. Like: all the words that are capitalized; all words that end in "ing"; URLs; XML tags; things that should be tabular but aren't; phone numbers; dates; timecodes...

Regex gives us a handle on such things – on regular patterns in text. It allows us to describe patterns in text, and then grab hold of those things and do things with them -- whether that's just finding them or doing something more active, like changing them, or collecting them, or doing some other processing on them.

This little *formal language* is actually very simple. There are only about 9 things to remember. See below for the 9 things.

There are loads and loads of websites that will teach you regular expressions.

Chapter 8 in the *BBEdit user manual* is excellent -- the best single reference I've seen.\
As of 2026, it's still at <https://s3.amazonaws.com/BBSW-download/BBEdit_13.5.6_User_Manual.pdf>




# Regular Expression Syntax: 9 Building Blocks

Here are slightly more than 9 basic rules for regular expressions. Get your head around these, and with a bit of practice, you'll be a regex magician.

## 1. Most characters simply match themselves:

	A B C a b c

	1 2 3

	Horatio

	\t    (tab)

	\n and/or \r    (for line breaks and carriage returns)

Any of these things -- individual characters or words, phrases, whole sentences -- are called 'strings.' A string is a regular expression that simply describes itself.

Today we will always treat our regular expressions as *case-sensitive*, even though many tools allow you to toggle that on or off. 


## 2. Some 'metacharacters' match more than just themselves

	\d  \w  \s  .

	= any digit; any 'word' element; any space; and any character at all


These items become much more powerful. The **dot** (or period), for instance, matches *any* character: you don't have to know what, but if there's a character there, it'll match. The `\d \w \s` forms are a little more specific: only matching a digit; a 'word' character (letters and numbers); a 'space' character (spaces or tabs, but not punctuation).


**Example**: `Latin.` would match *Latina*, *Latino*, and *Latinx*. It would also match *Latin* with a space or period after it. Of course, this could also match something like *LatinQ*, if that existed. It would not match all of *Latinum*, would it?

We could use `Latin\w` to do better...

**Example**: `\d\d\d\d` would match any year, or any sequence of four digits. It would also match four digits *within* a larger number (sigh). We have to pay attention what's actually in our content! 

We could use `\s\d\d\d\d\s` to do better; that would match four digits with some kind of space on either side. Would that always work?


## 3. Quantifiers

	?  *  +

	= optional; optional and repeatable; repeatable  
	= 0 or 1; 0 or more; 1 or more

We put these quantifiers after something we're matching, to specify how many of them can be there.

**Example**: `frogs?` will match both *frog* and *frogs* -- the 's' is *optional*

**Example**: `The answer is .*` will match *anything* -- any sequence of any characters that come after "The answer is "

**Example**: `June \d+` will match *any date in June*, whether it's a single digit or a two-digit number. Or a three-digit number :-)

The `.*` pattern is really common -- when you see it, you can think of it as meaning "whatever" or "anything."

## 4. Alternation (either\|or)

	a|b|c

	this|that

## 5. Parentheses group sub-patterns

	(apples|oranges)|vegetables

	(Jan|Feb|Mar|Apr|May) (\d+)

Items 4 and 5 make sense together, as in the examples shown here. *Parentheses* work more or less the same way they did in your ninth-grade algebra class: they group things for *priority*.

So in the first example above, apples or oranges gets parsed first, and only then will we consider vegetables.

Parentheses will come in handy later for taking what we've searched for and using it to replace text. But in general, you can and should *use parentheses liberally*, for the sake of clarity.

## 6. Character classes *(any one of this set...)*

	[ABCDEFGh]

	[A-Za-z0-9]

	[^\d]    = negation: anything that ISN'T a digit. The caret ^ means "not these"

The items in these bracketed sets are individual characters. Most commonly you'll see things like the second example, which means basically the same thing as `\w`.


## 7. Position operators

	^    $

	= match at start of line; end of line

By default, most regex tools assume the scope for matching is a *single line* (delimited by a line feed or carriage return character). So these two metacharacters allow us to specify things that match only at the beginning of a line `^` or at the end of a line `$`.

Just `^$` on its own will match a blank line.


## 8. *Escaping* reserved characters (i.e., being literal instead of meta)

	\?   \.   \+

	\[   \(   \)


Our 'metacharacter' vocabulary is starting to eat away at the characters we use to actually write with! So we need a way to say when we mean the character itself, and not the metacharacter. If we want to match an *actual* period or an actual question mark, we precede it with a backslash.

## 9. "Greedy" and non-greedy operators

	pattern+ (='greedy')

	pattern+? (='non-greedy')

	"(.+?)"


*"Because," he said, "sometimes there are two sets of quotation marks in a single sentence."*

If we tried to match quoted text by searching for `"(.*)"`, it would match the *entire* sentence, because `.*` also grabs the quotation marks in the middle of this sentence. The * operator is *greedy*!

So we can ask it to not be greedy by searching `"(.*?)"` *(note the extra question mark)*. This will only match the first quoted bit -- the minimal, non-greedy interpretation of this pattern. It should also match the second quoted bit as a separate match.

Those parentheses will allow us to isolate the quoted text (note that we put them *inside* the quotation marks).


## 10. Replacement patterns (for search & replace)

	\1  \2  \3

	$1 $2 $3  (some software prefers this version)

	= 1st, 2nd, 3rd (etc) sets of matched parentheses in search string, which can be *replaced* individually.

**Example**: In 1964, the #1 pop record was "I Want to Hold Your Hand" by The Beatles.

**Search**: `In (\d\d\d\d), the #1 pop record was "(.*)" by (.*)\.`

**Replace**: `Year: \1 - Song: \2 - Artist: \3`


If you composed the replacement pattern a little differently, with commas (or tabs) instead of dashes, you would have created a spreadsheet. Like so:

**Replace**: `\1,\2,\3`



## 11. There is more...

There are other pieces, but they're specific enough that you can google them if you need them.

The best way to proceed is to start with something simple, and build up. Constructing complicated regex patterns can drive you a bit mad, so take it slow; work incrementally; remember the *Undo* function in your editor!



# Challenge exercises!

### 1. Numbers of numbers

`\d+` will match any number, regardless of how many digits

How else could you write this to ensure that it is only a one- or two-digit number?


### 2. URLs and other regular-looking text

Could you find all the URLs in a file? Including both the ones that start with "http" *and* "https"? How do you specify where the URL ends, and the rest of the text (like, maybe a trailing period) continues?



### 3. Phone number normalization

Find variously formatted telephone numbers and normalize them: change them so they all have the same punctuation.

(345)789-2431  
(453) 543 3453  
435-123-1233   
546.667 9090  
345 543 1113  


### 4. Turn these pretty-regular sentences into tab-separated values (aka a spreadsheet)?

These apples cost 1.99.  
These bananas cost 1.49.  
These oranges cost 2.29.  
These strawberries cost 8.99.  
These blueberries cost 9.99.  
But salmonberries	are priceless!  

This data is very regular... can you turn it into tab-separated values suitable for opening up as a spreadsheet?

Alternatively, if you save out a spreadsheet as text (.csv format), could you reformat it as sentences?


### 5. Cleaning up Project Gutenberg texts

See the file: AliceDownRabbitHole.txt -- which is just the first bit of Lewis Carroll's *Alice's Adventures in Wonderland* from the Project Gutenberg collection of public-domain texts.

Find where the author typed 4 (or 5, or 3) spaces at the beginning of a paragraph, and get rid of those. Paragraph indents should be handled by a stylesheet, not by typing extra characters.

Find the quotation marks -- which are \` and ' -- and change that to proper quotation marks.

Find where there are two spaces after a period and reduce to one.

Find underlined phrases and change them to... uppercase? Or use asterisks to indicate italics instead?  

--- 

There are also friendly interactive learning tools like <https://regex101.com/> a website that provides an interactive environment for building regexes and testing them.

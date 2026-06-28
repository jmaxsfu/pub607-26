## Using the shell...

Let's look at the shell. If you open up the **Terminal app** on your Mac, or the **Command Prompt** on Windows, you will see a little window, with a tiny bit of information and a blinking *cursor*, awaiting your input. That bit of info varies from instance to instance, but it likely reports who you are, what machine you're logged in to, and *where you are* (what folder we are currently 'in'). And then there's typically a punctuation mark -- a $ or a % -- that we call the *prompt*.

Where to begin? Let's start by asking it to Print the Working Directory, to tell us *exactly* where in the filesystem we are currently.

    pwd

It should respond with a **path** -- that is, a sequence of nested folder names, separated by slashes. The folders start at the very top level of your drive, and then drilling down to where you are currently. If you've just opened up the shell, you are probably in your 'home directory.' 

Note that rather than looking *upon* a folder in a window on your screen, when you're using the shell you are *in* a folder (or in a 'directory' to use the older terminology). There's a spatial metaphor in the shell: you move yourself around within the filesystem, rather than looking on it from outside.

We can move into another folder (Change Directory) like so:

    cd Downloads

    pwd

And move back out (up) again, with two dots:
 
    cd ..

    pwd

 Let's ask it to List the contents of the current folder:

    ls

That produces a simple list of names. Possibly not all that useful; there's no easy way to distinguish between files and subfolders, except by the clues given in the names themselves. We can ask for more detail by adding to the `ls` command a **flag** -- passing it a *parameter*, or an *argument*. The syntax for this is pretty standard: almost all unix commands can be modified by various flags, and we indicate them with a hyphen:

    ls -l 

 This asks for the 'long' version of the list of folder contents. Now you see a bunch of metadata about each item:

 - is is a Directory? if so, the line starts with 'd';
 - permissions (who's allowed to read, write, or execute it);
 - ownership information, both individual and 'group';
 - size of the file in bytes;
 - modification date;
 - file or folder name.

NB: This is the same information you can find out if, in your usual folder window, you ask for 'Get Info' (on a Mac) or "Properties" (Windows) for a file or folder.

Pick a folder, (I'll use my 'Downloads' folder as an example, which is at hand if I'm currently in my 'home directory'), and ask for the long list (`ls -l`) of its contents:

    ls -l Downloads    

If you're like me (and your laptop isn't brand new) this produces a very, very long list. It flies by so fast you can't even see it, except the last screenful. 

We can ask the shell to slow down, and give us the list one screenful at a time, and even to wait for us to tell it to move on to the next screen's worth. We're going to use the Unix **pipe** construct here -- a very powerful tool -- which we refer to with the **|** symbol (shift-slash, on English-speaking keyboards):

    ls -l Downloads | more

`more` is another Unix command that says, "If you give me a sequence of lines of text, I'll give it back to you, but just one screenful at a time. You hit the spacebar when you want *more*."  It shows a colon prompt to indicate it's waiting for you to tell it to go to the next screen -- just hit space. You can also optionally hit the return key, in which it will advance only one line at a time.

The Unix *pipe* allows us here to introduce a concept: **redirection**.

When we asked for the file listing, without piping it to the `more` program, the results go to a Unix *device* called "standard output" which is (99.9% of the time) your screen. By using the | symbol, we asked the shell to **redirect** the results of `ls -l` to another program instead of to the screen: to the `more` program instead. Then `more` sends *its* output to STDOUT (the screen), but in a more controlled way.

So here's a mainstay of Unix: *the output of one program can be the input of another.*

We can also redirect the output of a program to a file. We do this by using the **>** symbol:

    ls -l > my-file-listing.txt

You have just created a new file, "my-file-listing.txt' -- you can watch that happen in your regular Mac/Windows folder view, too. When you run that command, a new file is born! 

If you look inside that file, you'll find the output of `ls -l`, saved for posterity. You can open that file up with Sublime Text (or Word, or whatever). You could also use a tool you've already seen to look inside that file:

    more my-file-listing.txt

This demonstrates a second mainstay of Unix: *everything behaves like a file*, whether it is a file, or the output of another program, or some other stream of text coming from someplace. `more` doesn't care whether you use it to show the contents of a file or feed it a stream of text from some other program; it just does its job, giving you lines, one screenful at a time.

*Most of the Unix shell works like this*. Little programs that take some kind of input, usually text, and from that generate some kind of output, usually text. They can work with 'standard input' and 'standard output', or then can read from files and write to new files; or they can take a stream of input from another program, and output that as a stream of input for another program. It all works the same.

If 'standard output' is your screen, then what's 'standard input'?  Try this:

    > story-of-my-life.txt

...and start typing. Begin with your birth, and you can stop when you get bored. When you're done, type `ctrl-D` (control key + d). Now you can read what you wrote:

    more story-of-my-life.txt

Not ready for anyone to read that document? You can delete (*remove*) it by saying:

    rm story-of-my-life.txt

That's enough detail for now. There is a quick reference "Some Unix commands" you can consult. And for any Unix command, you can easily reference the documentation for it by asking for its 'Manual':

    man ls

    man more

You may discover, in doing so, that `more` is `less`. 

You can generally type Q to break out of endless screens of man pages (or anything that comes to you via `more`).


## Three handy tips to improve your day!

Modern command shells (the ones on our laptops today are *highly evolved versions* of the ones from the 1970s) have some nice features that will make our lives easier. 

When you're working in the shell, try to remember these three things:

1) The shell *remembers* what you've just typed: you can easily **go back to a previous command** by hitting the *up arrow* key. You can walk through all your recent commands by using the up and down arrow keys. Then just hit return to execute it again.

2) If you are typing a command, or (and *especially*) a filename, and you have typed the first few letters, you can hit *TAB*, and the shell will do its best to **complete the rest of it automatically**. That saves keystrokes, and more importantly it saves typos.

3) If you type just `cd` all by itself, it will change directory back to your **home directory** (aka ~). 

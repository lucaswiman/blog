---
layout: post
title:  "Prosaic Prolog: Unit testing with SWI Prolog"
date:   2015-11-21 13:38:45 -0800
categories: prolog testing unit-tests prosaic-prolog
---
I've been trying to learn Prolog. One of my frustrations has been that doing prosaic, simple things seems to be either poorly documented or confusing (because of the paradigm shift required by writing logic programs). The other issue is that the language seems to used only in teaching nowadays, which means that resources I can usually depend on like StackOverflow are flooded with people asking for help with their homework problems. To that end, I'm recording simple "prosaic" tasks in "Prosaic Prolog" posts.

The goal here is the following: set up a directory structure and list of files so that I can run `make test` from the command line and have it tell me if there's a bug.

## Buggy code

To start out, let's write a buggy predicate `add/3`, which is just like arithmetic addition, except it thinks that 2+2 is 5. Here are the contents of `bug.pl`:

{% highlight prolog %}
add(2, 2, 5) :- !.
add(X, Y, Z) :- Z is Y + X, !.
{% endhighlight %}

This code predicate defines two rules. The first says "2 plus 2 is 5 *and* it's not anything else" (The "not anything else" is set by the [cut operation `!`](https://en.wikibooks.org/wiki/Prolog/Cuts_and_Negation)). The second says "`add/3` behaves like regular addition".

You can see that this is buggy by running it in swi-prolog:

{% highlight prolog %}
$ swipl

?- [bug]. % This loads the module bug contained in bug.pl.

% bug compiled 0.00 sec, 3 clauses
true.

?- add(2, 2, 5).
true.

?- add(2, 2, X).
X = 5.

?- add(2, 3, 6).
false.

?- add(2, 3, X).
X = 5.
{% endhighlight %}

Since rules are checked in the order they're loaded, the first rule matched, and the cut meant we could stop looking for more solutions.

## Running a Test from the Command Line


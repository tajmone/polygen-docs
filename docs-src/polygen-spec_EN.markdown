---
css: assets/polyman.css
############################## DOCUMENT INFO DATA #############################
# !define( DocVer   )( v1.1.1-rc  ) <- Document version number
# !define( PMLVer   )( 1.0        ) <- PML version number
# !define( DocDate  )( 2020-09-09 ) <- Document last edited (YYYY-MM-DD)
# !define( PolygenV )( v1.0.6     ) <- Polygen version the doc applies to
###############################################################################
lang: en
title:         Polygen Meta Language Spec !PMLVer
subtitle:      Introductiory guide to using PML
author-meta:   Alvise Spanò
date-meta:     !DocDate
description: |
   Polygen Meta Language (PML) v!PMLVer — Technical specification and
   introductiory guide to using PML.
keywords:
   - polygen
   - language
   - grammar
   - specification
   - pml
   - ebnf
toc-title:     Contents
#==============================================================================
#                           pandoc-crossref settings
#==============================================================================
numberSections: true
sectionsDepth: -1
secPrefix:
    - "section"
    - "sections"
linkReferences: true
nameInLink: true
chapters: true
autoSectionLabels: true
#==============================================================================
#                            Text Block Before TOC
#==============================================================================
summary: |
   Edition **!DocVer** (!DocDate) for **PML !PMLVer**, Polygen **!PolygenV**.

   :::::: Note ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   __Copyright © 2002-18 Alvise Spanò.__ This document is subject to the
   terms of the [GNU General Public License] (GPLv2+); either version 2 of the
   License, or (at your option) any later version. You can redistribute it
   and/or modify it under the same license terms.

   New digital edition by [Tristano Ajmone] (February 2018).
   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
...

!define( FIXME )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
:::::: Warning :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
__FIXME__: !1
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!define( MISSING_HEADING )( ~~__*MISSING SECTION*__~~ )

!define( MISSING_CONTENTS )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:::::: Warning :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
__MISSING TRANSLATION__: This section needs to be translated
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# What is a grammar?

A grammar is an ASCII text file providing the definition of the syntactical structure and terms used by the program to build sentences. *Polygen* is able to interpret a language designed for defining *[Type-2]* grammars (according to Chomsky classification) consisting in an extension of the *EBNF ([Extended Backus Naur Form])* --- a very simple and common notation for describing the formal syntax of a language.

A definition consists in specifying for a given symbol a set of __productions__ interleaved by a **pipe** `|` and followed by a **semicolon** `;` terminator:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= an apple | a mango | an orange ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
an apple
a mango
an orange
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The above definition of the `S` symbol (called a **non-terminal**) allows generating the symbols `an apple`, `a mango` or `an orange` (called **terminals**).

The probability of the generated output being `an apple` is 1 every 3 times; and the same applies to `a mango` and `an orange`: thus, when dealing with 3 productions, each has 1 out of 3 chances; with 5 productions, each has 1 out of 5 chances; and so on.

In order to flexibily generate complex sentences, you can define several non-terminal symbols and reference them from any productions:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= the Animal is eating Fruit ;

Animal ::= cat | dog ;
Fruit ::= an apple | a mango ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
the cat is eating an apple
the cat is eating a mango
the dog is eating an apple
the dog is eating a mango
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

etc.

:::::: Note ::::::::::::::::::::::::::::::::
**Note:** By default, *Polygen* uses `S` as the starting non-terminal symbol; therefore every grammar should provide at least its definition (unless a different starting symbol is specified via the program options).
::::::::::::::::::::::::::::::::::::::::::::

Any term beginning with a capital letter is considered a non-terminal symbol (therefore bound to a definition) and any term beginning with a non-capital letter is considered a terminal symbol (i.e., just a word). If you need to generate a word starting by capital letter you must enclose it within double quotes, so that the program doesn't mistake it for a non-terminal symbol:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a Pet called "Pet" ;

Pet ::= cat | pig | dog ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a cat called Pet
a pig called Pet
a dog called Pet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bear in mind that many characters (punctuation marks, parentheses, brackets, etc.), including those interpreted by the program as keywords, must be quoted in order to be included in the output (see [@sec:lexical-rules] for the complete lexical rules).

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= "(" (apple | orange) ")" ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
( apple )
( orange )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Subproductions

In the right-hand side of a definition (i.e., after the keyword `::=`) a subproduction of any form can be specified within round brackets:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= an (apple | orange) is on the (table | desk) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
an apple is on the table
an apple is on the desk
an orange is on the table
an orange is on the desk
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subproductions are generated as standalone blocks, as if they were bound to a non-terminal symbol.

## Optional subproductions {#sec:optional-subproductions}

A subproduction specified between square brackets is considered optional and has 50% probability of being generated (1 out of 2):

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= an (apple | orange) is on the (table | desk) [in the (living | dining) room] ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
an apple is on the table
an apple is on the table in the living room
an apple is on the table in the dining room
an orange is on the table
an orange is on the table in the living room
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

etc.

Beside being generated once every two times, optional subproductions behave just as normal subproductions.

## Comments

You can write any kind of text within a pair of `(*` and `*)` keywords. Such text will be completely ignored by *Polygen.*

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= apple | orange (* | banana *) | mango ;
(* this is a comment too *)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
apple
orange
mango
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Advanced features

*Polygen* provides a set of keywords that raise the expressivity of its grammars definition language far beyond *EBNF*.

## Concatenation

The **caret** `^` can be prefixed, suffixed or infixed anywhere within a production in order to prevent the program from inserting a space character in the output string:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= "(" ^ (apple | orange) ^ ")" ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(apple)
(orange)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Concatenation is a particularly useful feature when you need to generate words by assembling syllables or letters from different productions:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= "I" Verb ^ e Verb ^ ing ;

Verb ::= lov | hat ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I love hating
I love loving
I hate hating
I hate loving
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bear in mind that a sequence of multiple carets will be treated as if there was just a single caret (i.e., redundant carets will be ignored).

## Epsilon {#sec:epsilon}

The **underscore** keyword `_` represents an empty production, formally called **epsilon**.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= ball | _ ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ball
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Beware that an epsilon-production is neither the underscore character itself nor the space character, but rather the lack of ouput  — or empty string, if you prefer. The previous example is perfectly equivalent to the following:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= [ball] ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ball
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I.e., a grammar generating either `ball` or nothing as output.

## Controlling the probability of a production {#sec:controlling-probability-production}

Prefixing the **plus** keyword `+`  to a (sub)production (regardless of its nesting level) increases its probability of being generated above other productions of the same series; likewise, the **minus** keyword `-` reduces its probability. Any number of `+` and `-` keywords may be specified:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= the cat is eating (+ an apple |- an orange | some meat |-- a lemon) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
the cat is eating an apple
the cat is eating an orange
the cat is eating some meat
the cat is eating a lemon
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The set of producible sentences is as expected; indeed, the definition for the non-terminal symbol `S` is internally interpreted as follows:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= the cat is eating ( an apple  | an apple | an apple | an apple
                        | an orange | an orange
                        | some meat | some meat | some meat
                        | a lemon) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

the requested increases and decreases in probability are proportionally fulfilled: `an apple` has the highest probability of being generated, followed by `some meat`, then `an orange`, and lastly by `a lemon`, which has the least probability of all.

## Unfolding {#sec:unfolding}

*Polygen* provides a powerful unfolding system which, in general, allows to raise a series of productions (which would otherwise be folded either by a subproduction or a non-terminal symbol) to the level of the current sequence.

Roughly, you could consider this operation as *flattening* a portion of the grammar before its generation, thus affecting it only as far as probabilities are concerned, since the transformation does not alter the source grammar's semantics — as the traslation rules in section [4.1.5](#4.1.5_Regole_di_traduzione) confirm.

Not every atom supports unfolding though, only those for which this operation makes sense do: refer to [@sec:concrete-syntax] for a syntactical formalization of this subset.

### Non-terminal symbols {#sec:non-terminal-symbols}

Consider the following scenario:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= ugly cat | nice Dog ;

Dog ::= poodle | beagle | terrier ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ugly cat
nice poodle
nice beagle
nice terrier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Here `ugly cat` has 1 probability of being generated every 2 times, but the same chances don't apply to `nice poodle`, `nice beagle` and `nice terrier`, even though it's tempting to think that they should all share the same probability.

The problem here is that `ugly cat` and `nice Dog` are taking equal shares in the production of `S`: the chances of `ugly cat` being generated are the same (1 out of 2) as those of `nice Dog` --- i.e., either `nice poodle`, `nice beagle` or `nice terrier`. In the above example, the probability distribution is as follows:

|                |                  |
|----------------|------------------|
| `ugly cat`     | 1/2              |
| `nice poodle`  | 1/2 \* 1/3 = 1/6 |
| `nice beagle`  | 1/2 \* 1/3 = 1/6 |
| `nice terrier` | 1/2 \* 1/3 = 1/6 |

As a proof: 1/2 + 1/6 + 1/6 + 1/6 = 1.

In order to redistribute equally the probabilities of subproductions, `S` should redefined this way:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= ugly cat | nice poodle | nice beagle | nice terrier ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

but this way we lose the original architecture, which folded all dog breeds within a dedicated non-terminal symbol, and drastically increases the amount of editing work required.

In order to solve this problem (which is an instance of the broader problem of irregular distribution of probability affecting subproductions), the language offers an operator for **unfolding** non-terminal symbols:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= ugly cat | nice >Dog ;

Dog ::= poodle | beagle | terrier ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By prefixing the `>` keyword to a non-terminal symbol, we instruct the program to perform (during the preprocessing stage) the transformations mentioned above, changing the probability distribution as follows:

|                |     |
|----------------|-----|
| `ugly cat`     | 1/4 |
| `nice poodle`  | 1/4 |
| `nice beagle`  | 1/4 |
| `nice terrier` | 1/4 |

### Subproductions {#sec:unfolding-subproductions}

It is not uncommon to use subproductions in order to diminish a grammar's verbosity; e.g., by collecting verbs into sets according to the preposition they depend on.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (walk | pass) through
   |  look at
   |  (go | come | move | link | run) to ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While on the one hand a grammar's architecture and scalability benefit from this, on the other hand the quality of its output is negatively affected since 1 out of 3 times `look at` will be generated (for the same reason discussed in [@sec:non-terminal-symbols]). In order to bring the output to the desired level of etherogeneity --- i.e., where each single verb may be produced with the same probability --- the user should avoid using round brackets, to lift the limit of having only 3 macro-productions, and add next to each verb the required preposition --- in other words, give up the original architecture of the grammar.

For this very purpose, any subproduction may be **unfolded** in a similar manner as mentioned in [@sec:non-terminal-symbols] regarding non-terminal symbols. The `>` operator instructs the program to delegate to the preprocessor the unfolding of the following subproduction, allowing the user to keep the original source architecture unchanged.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >(walk | pass) through
   |  look at
   |  >(go | come | move | link | run) to ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

is translated into:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= walk through | pass through
   |  look at
   |  go to | come to | move to | link to | run to ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

that is what one would expect: a flat series of productions.

A more complex example could be:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Digit ::= z: 0 | nz: >(1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

is translated into:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Digit ::=  z: 0 | nz: 1 | nz: 2 | nz: 3 | nz: 4 | nz: 5 | nz: 6
       |  nz: 7 | nz: 8 | nz: 9 ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Optional subproductions {#sec:unfolding-optional-subproductions}

A subproduction within square brackets (see [@sec:optional-subproductions]) is like a subproduction within round brackets which produces either the original content or **epsilon** (see the example in [@sec:controlling-probability-optional]).

Therefore, **unfolding** an optional subproduction is perfectly legal and the result is analogous to what was mentioned in [@sec:unfolding-subproductions].

### Permutable subproductions

As the translation rules in [@sec:translation-rules] reveal, __unfolding__ is performed by the preprocessor after carrying out all permutations (see [@sec:permutation]): a permutable subproduction bound to a `>` operator is therefore permutated first, and then **unfolding** is applied to the new position within the sequence.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >{the >(dog | cat)} and {a (fish | bull)} ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pay close attention to the differences in behavior between the unfolding outside the curly braces and that inside them; the translation is as follows:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= the dog and a (fish | bull)
   |  the cat and a (fish | bull)
   |  a (fish | bull) and the dog
   |  a (fish | bull) and the cat ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Deeply unfolded subproductions

As stated in [@sec:deep-unfolding], deep unfolding leads to a subproduction where everything has been flattened out.

Nevertheless, sometimes one may wish to further **unfold** that very subproduction.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::=  > >> the (dog | cat) | a (fish | bull) << | an alligator ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

which translates into:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= the dog | the cat | a fish | a bull | an alligator ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Attributes

### Labels and selection {#sec:labels-selection}

Any (sub)production, regardless of its nesting level, can be bound to a label which can then be used in conjunction with the **dot** selector to constrain its production to a specific subset.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Verb.inf | Verb.ing ;

Verb ::= (inf: to) (eat | drink | jump) (ing: ^ing) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
to eat
to drink
to jump
eating
drinking
jumping
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The selection simply excludes all the (sub)productions bound to any label other than the selected one. More precisely, a selection propagates the label specified on the right-hand side of the dot operator for the whole generation of what lies on its left-hand side; during the generation, only (sub)productions which are either unbound to any label, or bound to the selected one, will be considered valid.

Bear in mind that you can use consecutive selections, at different times, to populate the list of selected labels: this technique may be useful for propagating specific attributes to affect the generation.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (Conjug.S | Conjug.P).sp | (Conjug.S | Conjug.P).pp ;

Conjug ::= (Pronoun Verb).1 | (Pronoun Verb).2 | (Pronoun Verb).3 ;

Pronoun ::= S: (1: "I" | 2: you | 3: (he | she | it))
         |  P: (1: we  | 2: you | 3: they) ;

Verb ::= (pp: Be) (eat | drink) (sp: (S: (3: ^s)) | pp: ^ing) ;

Be ::= S: (1: am | 2: are | 3: is) | P: are ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I eat
you eat
he eats
she eats
it eats
we eat
they eat
I am eating
you are eating
he is eating
we are eating
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

etc.

In the above example --- where the labels `1`, `2`, `3`, `S` and `P`  identify the syntactical forms for the first, second and third persons, and the singular and plural, respectively --- we managed to correctly conjugate both simple present and present progressive tenses according to pronoun.

### Multiple selection

Reconsider the example in [@sec:labels-selection]; basically, the production activates both labels pairs before descending into the generation of the non-terminal `Conjug`: both `S`, `P` and `sp`, `pp` pairs are mutually activated, with the objective of generating all possible combinations of pronouns and conjugation suffix patterns. Nevertheless, similar cases introduce inelegant repetitions: the `(Conjug.S | Conjug.P)` subproduction is replicated twice (once for label `sp`, and then again for `pp`).

To avoid this kind of verbose repetition it's possible to activate multiple labels through a single selection operation, by separating them with the **pipe** keyword. The previous example can thus be simplified to:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Conjug.(S|P).(sp|pp) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Analogously to what stated in [@sec:controlling-probability-production] for grammar productions, it's possible to specify probablity modifiers for labels too, by means of the `+` and `-` keywords.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Ogg.(+S|--P).(sp|-pp) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

which internally is treated as:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (Conjug.S | Conjug.S | Conjug.S | Conjug.S | Conjug.P).sp
   |  (Conjug.S | Conjug.S | Conjug.S | Conjug.S | Conjug.P).sp
   |  (Conjug.S | Conjug.S | Conjug.S | Conjug.S | Conjug.P).pp ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Selection reset

Keep in mind that the selection operator adds the specified label to the set of already active labels; this leads to the need of manually resetting that particular set from time to time. For example, let's generate natural numbers (including zero) of arbitrary length, without leading zeros:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Digit | S.nz [^S.] ;

Digit ::= z: 0 | nz: >(1| 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0
1
23
23081993
112358
20020723
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

etc.

When a **dot** operator not followed by a label is encountered during generation, the set of active selections is reset there and then; in other words, it stops further propagation of the labels so far selected.

## Capitalization

It is often required, mainly for style purposes, to respect capitalization rules --- for instance, after a full stop.

Nevertheless, a complex grammar architecture, providing recursive productions generating subclauses, may render such an operation impossible, unless the user rewrites part of the source.

In order to solve this problem, the language provides the **backslash** keyword `\`, which instructs the program to capitalize the first letter of the next terminal symbol encountered (if it isn't already a capital letter).

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= \ smith (is | "." \) Eulogy ^ "." ;

Eulogy ::= rather a smart man
        |  really a gentleman ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Smith is rather a smart man.
Smith. Rather a smart man.
Smith is really a gentleman.
Smith. Really a gentleman.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bear in mind that **backslash** capitalization is active until the following generated terminal symbol is encountered, therefore any other atom (epsilon, concatenation or the capitalization operator itself) encountered in the meantime will act as usual.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a \ ^ \ _ b
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
aB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Permutation {#sec:permutation}

Many spoken languages allow changing the order of some words (or groups of words) in a sentence without altering its original meaning; likewise, at a macroscopic level, sometimes it is possible to swap the order of sentences within a phrase.

To avoid writing each and every variation of a sequence in which some atoms swap positions, you can enclose within **curly brackets** `{` and `}` the subproductions that need to be permutated.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= whether {is} {therefore} {he} ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
whether is therefore he
whether is he therefore
whether therefore is he
whether therefore he is
whether he therefore is
whether he is therefore
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bear in mind that a subproduction's permutability only affects the sequence that contains it: no permutation occurs if permutable subproductions are specified in different subsequences (or subprodutions --- permutable or not). See the differences in the following two examples:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= {in 10 minutes}^"," {at 3 o'clock}^"," {"I" {will depart} {alone}} ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
in 10 minutes, at 3 o'clock, I will depart alone
at 3 o'clock, in 10 minutes, I will depart alone
in 10 minutes, I will depart alone, at 3 o'clock
at 3 o'clock, I will depart alone, in 10 minutes
I will depart alone, in 10 minutes, at 3 o'clock
I will depart alone, at 3 o'clock, in 10 minutes
in 10 minutes, at 3 o'clock, I alone will depart
at 3 o'clock, in 10 minutes, I alone will depart
in 10 minutes, I alone will depart, at 3 o'clock
at 3 o'clock, I alone will depart, in 10 minutes
I alone will depart, in 10 minutes, at 3 o'clock
I alone will depart, at 3 o'clock, in 10 minutes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= {in 10 minutes}^"," {at 3 o'clock}^"," ("I" {will depart} {alone}) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
in 10 minutes, at 3 o'clock, I will depart alone
at 3 o'clock, in 10 minutes, I will depart alone
in 10 minutes, at 3 o'clock, I alone will depart
at 3 o'clock, in 10 minutes, I alone will depart
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Deep unfolding {#sec:deep-unfolding}

The language allows the deep unfolding of a subproduction enclosed within reversed double angle brackets `>>` and `<<`: any atom (at any nesting level) for which unfolding makes sense (see [@sec:unfolding]) will be unfolded. As a result, every subproduction and non-terminal symbol within `>>` and `<<` is completely flattened out:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= look at >> the (dog | (sorian | persian) cat)
               | a (cow | bull | Animal)
              << ;

Animal ::= pig | (weird | ugly) chicken ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The non-terminal `S` is translated into:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= look at ( the dog
              | the sorian cat
              | the persian cat
              | a cow
              | a bull
              | a pig
              | a (weird | ugly) chicken
              ) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Deeply unfolded subproductions are therefore translated into a subproduction where everything has been recursively flattened out, except for subproductions bound to non-terminal symbols --- because deep unfolding consists in a simple unfolding of every (sub)atom for which such an operation makes sense; therefore, while non-terminals are unfolded, productions bound to them are left untouched. Even though such a policy may seem unjustified at first, it allows users to specify any non-terminal symbol inside a double-angle bracketed subproduction, without unintentionally generating either a huge series of unfoldings or --- even worse --- cyclic unfoldings (see [@sec:recursive-unfoldings]).

## Folding

Deep unfolding, as described in [@sec:deep-unfolding], may sometimes not be desirable in its full extent: on the one hand, it's mostly used to avoid the need of a `>` operator for every subproduction or non-terminal symbol within a given subproduction; on the other hand, it's often impossible to perform a deep unfolding of every (sub)atom without generating (unintentional) errors. The *Polygen* grammar definition language therefore allows users to **lock** the unfolding of an atom (for which unfolding makes sense) by prefixing the operator `<`.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= look at >> the (dog | <(sorian | persian) cat)
               | a (cow | bull | <Animal)
              << ;

Animal ::= pig | (weird | ugly) chicken ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

where the non-terminal `S` is translated into:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= look at ( the dog
              | the (sorian | persian) cat
              | a cow
              | a bull
              | a Animal
              ) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bear in mind that folding an unfolded atom, and viceversa, are syntax errors (see rules in [@sec:concrete-syntax]).

## Binding {#sec:binding}

Binding are, in general, declarative constructs that associate a series of productions to a non terminal symbol.
Each binding introduces that association in the environment where it is declared (see [@sec:environment-scoping]), and every production generated in that environment can refer to its non terminal symbol.

### Closures {#sec:closures}

The `::=` keyword introduces the so-called _weak_ binding, or _closure_, which has already been amply discussed in this document.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Fruit and Fruit ;

Fruit ::= an apple | a mango | an orange ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
an apple and an apple
an apple and a mango
an apple and an orange
a mango and an apple
a mango and a mango
a mango and an orange
an orange and an apple
an orange and a mango
an orange and an orange
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The production associated to `Fruit` __does not__ undergo an immediate generation but is closed together with the current environment according to scoping rules. Each occurrence of the `Fruit` symbol in a descending environment (or in the same one, as in the example) causes the generation of the associated production in the environment that was closed with it.

### Suspensions {#sec:suspensions}

The `:=` keyword introduces a second kind of binding, known as _strong_ binding, _suspension_ or _assignment_.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Fruit and Fruit ;

Fruit := an apple | a mango | an orange ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
an apple and an apple
a mango and a mango
an orange and an orange
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The production associated to `Fruit` is suspendend and closed together with the current environment according to scoping rules. During generation, at the first occurrence of the `Fruit` symbol in a descending environment (or in the same one, as in the example) the associated production is generated __just once__ in the environment that was closed with it, and the immutable result of its generation is stored in the environment; every successive occurrence of the same non terminal will always produce the same result.

Please note that during its first generation the non terminal is still associated to the closure of the environment where it's being generated, and not (yet) to its suspension: this allows the use of recursion in strong binding deinitions.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= A A ;

A := a | a ^ A ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a a
aa aa
aaa aaa
aaaa aaaa
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

etc.

## Environment and scoping {#sec:environment-scoping}

The environment is the context and ensemble of bindings (see [@sec:binding]), i.e., of the associations between non terminal symbols and series of productions. The environment can be populated either by top-level bindings or by those introduced by scope constructs.

### Top-level environment

All the various examples discussed so far dealt with bindings (of various types) introduced at the top-level of a source file, separated by the `;` keyword. As we've already mentioned, similar bindings are introduced into the (empty) environment according to a relation of mutual recursion: every production bound to a non terminal can reference any non terminal symbol which is defined at the top-level, be it upsteam or downstream, including the one the production itself is bound to.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= S | A | B | s ;

A ::= S | A | B | a ;

B :=  S | A | B | b ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It's easy to imagine the powerful potentials offered by this sytem.

### Local envirnoments

Within a subproduction (of any type) it's possible to introduce new bindings with local visibility: the subproduction's body (which consists of a series of productions) can be preceded by a series of semicolon-separated bindings, where the last `;` separates the last binding from the subproduction's main body.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= \i am (X := Adj; Very ::= very [Very]; X ^ "," maybe Very X | definitely Very Adj) and Adj ;

Adj ::= handsome | nice ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I am handsome, maybe very handsome and nice
I am handsome, maybe very handsome and handsome
I am handsome, maybe very ... handsome and nice
I am handsome, maybe very ... handsome and handsome
I am nice, maybe very nice and handsome
I am nice, maybe very nice and nice
I am nice, maybe very ... nice and handsome
I am nice, maybe very ... nice and nice
I am definitely very handsome and nice
I am definitely very handsome and handsome
I am definitely very .. handsome and nice
I am definitely very .. handsome and handsome
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The visibility (or scope) of the various non terminals in the above example is clear: `X` and `Very` are local to the subproduction that defines them, while `Adj` is used by both the subproduction's body as well as by the body of `S`.

Pay close attention to how the scoping constructor is being used in conjuction with strong binding (see [@sec:suspensions]): symbol `X` is introduced locally, with the sole purpose of _fixing_ the generation of `Adj`, which in the top-level environment is defined via a weak binding (see [@sec:closures]). The combined use of scopes with the various types of bindings is a powerful feature of the language, unleashing new possibilities for the engineering of grammars.

Also note that the above example doesn't rely on local bindings' mutual recursion, and that the same result could have been achieved by inserting 2 scopes:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= \i am (X := Adj; (Very ::= very [Very]; X ^ "," maybe Very X | definitely Very Adj)) and Adj ;

Adj ::= handsome | nice ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nothing prevents a subproduction's body from being a subproduction itself: this allows populating the environment without creating a mutually recursive relation between the bindings.

Finally, bear in mind that __any__ type of subproduction can introduce local bindings.

### Static lexical scoping

Scoping rules are at the same time strict and intuitive: every production is generated in the environment where it was defined. Even though environments can be populated with locally inserted bindings, it's __not__ possible to use symbols defined in the current environment to generate a production defined elsewhere, __even__ if these symbols are same-named.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= a | b; A) ;

A ::= X X ;

X := x | y ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x x
y y
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because of __static__ scoping, the local binding of `X`, inside the subproduction of `S`, yelds no effect in the generation of `A`, because the latter was _closed_ together with its environment of definition (see [@sec:closures]) --- i.e., the top-level environment, where `X` is bound to the `x | y` production.

Furthermore, lexical scoping rules allow __overriding__ (or __shadowing__) bindings:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= a | b; (X ::= x | y; X)) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x
y
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Inside the second inserted subproduction, the external definition of `X` is not visible. Obviously, the same rules apply also to the top-level environment.

Bear also in mind that bindings are recursive, therefore you can't refer to a symbol's environment definition from within an override redefinition of the same symbol.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= a | b; (X ::= x [X]; X)) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x
x x
x x x ...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The occurrence of `X` inside the second inserted binding is thus seen as a recursion, not as a reference to the `X` of the parent environment.

Similarly, in presence of a series of binding related by mutual recursion:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X ::= x [A]; A ::= a [X]; (X ::= y [A]; A ::= b [X]; X)) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
y b
y b y b
y b y b y b ...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Positional generation

Even though labels are powerful and versatile, in most scenarios they're used just to _filter_ a series of productions that specify disjointed syntactical cases of a given language --- common examples of such usage are: suffixes for articles, nouns and adjectives according to gender and number; or conjugation of verbs according to person, tense and mood.

In similar scenarios, the user is looking for a way to activate a certain label (e.g., that of gender) and then expect the production to take place accordingly. Sometimes this is only required for a single sentence:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= ((M: he | F: she) is a (M: handsome | F: pretty) act ^ (M: or | F: ress)).(M|F) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
he is a handsome actor
she is a pretty actress
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As a workaround to the burden of having to specify local labels, and activate them in place, the language offers a system of automatic positional generation.
This feature --- which is operationally equivalent to using labels and selections, but less verbose --- allows to express in an extremely concise way groups of suffixes, declinations, conjugations, etc. The `,` keyword is used to separate the atoms representing the possible choices:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= he,she is a handsome,pretty act ^ or,ress ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The final result is identical to that of the previous example; the difference is that no labels are used here: in accordance with the translation rules of [@sec:translation-rules], every production containing groups of comma-separated atoms is translated into a subproduction containing as many pipe-separated productions as the number of atoms in the group, and each production presents the __i__^th^ atom of each group, for every __i__. The above example is thus translated into:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= he is a handsome act ^ or | she is a pretty act ^ ress ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The obvious limitation of this feature is that all the groups in a given production must contain __the same number of atoms__. Also, bear in mind that the _scope_ of this constraint is a single production.

It's important to understand that positional generation is not a substitute of the labels system, rather it's a concise alternative to it for those frequent scenarios where it would be employed for declination purposes. Nonetheless, it's easy to envisage how this feature could be useful in other contexts too; for example, on a macroscopic level, to specify relations between portions of a sentence:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= time,fruit flies like an,a arrow,banana ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
time flies like an arrow
fruit flies like a banana
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Iteration

Although scoping constructs (see [@sec:environment-scoping]) allow iterating a production in a very simple and concise manner, sometimes the use of a dedicated iteration construct similar to EBNF's [Kleene closure] can be more friendly:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= she is s^ (o^)+ pretty ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
she is so pretty
she is soo pretty
she is sooo pretty
...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As one might expect, any kind of production can be placed inside the iterated subproduction:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (a | b)+ ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
b
a a
a b
b a
b b
a a a
a a b
a b a
...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One might have --- quite reasonably so --- expected to see the same generation being iterated every time, but this is not the case (as stated in the [translation rules @sec:translation-rules]) because in most scenarios the behavior of the above example is the preferable one instead, and also because it bears semantic affinity with its analogous EBNF construct. It's nevertheless possible to achieve the former behavior in a rather simple manner, by exploiting strong binding (see [@sec:suspensions]):

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (X := a | b; (X)+) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
b
a a
b b
a a a ...
b b b ...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Advanced techniques

## Recursion

In order to achieve recursiveness, you can specify inside a production the non-terminal symbol you're defining:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= Digit [^ S] ;

Digit ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0
23
853211
000000
00011122335
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

etc.

i.e., a random natural number made up of one or more digits ranging from 0 to 9.

Bear in mind that you'll need to provide a non-recursive production somewhere along the line, in order to guarantee to the program an exit point from the recursion, at one point or another; otherwise, a cyclic recursion error will be generated by the grammar checker (see [@sec:cyclic-recursions]).

As an exercise, try to define a grammar for generating variable-length sentences by recursively linking subordinate clauses.

## Grouping

In order to control the distribution of probability with finer granularity than described in [sections @sec:controlling-probability-production] and [-@sec:unfolding], mastery in the proper usage of round brackets is the key:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S1 ::= cat | cow | camel ;

S2 ::= cat | (cow | camel) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat
cow
camel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although the output of `S1` and `S2` is identical, their probability distribution isn't.

The distribution for the former is:

|         |     |
|---------|-----|
| `cat`   | 1/3 |
| `cow`   | 1/3 |
| `camel` | 1/3 |

while for the latter:

|         |                  |
|---------|------------------|
| `cat`   | 1/2              |
| `cow`   | 1/2 \* 1/2 = 1/4 |
| `camel` | 1/2 \* 1/2 = 1/4 |

All this because the subproduction `(cow | camel)` is interpreted by the program as a single block.

## Controlling the probability of an optional subproduction {#sec:controlling-probability-optional}

*Polygen*’s grammars definition language does not allow any direct control over the probabilities of an optional subproduction. In other words, there is no **plus**- or **minus**-like operator for subproductions within square brackets.

Nevertheless, this can be achived via a very simple technique:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a (+ _ | beautiful) house ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a house
a beautiful house
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since an optional subproduction is a _de facto_ equivalent of a non-optional subproduction generating either the desired output or **epsilon** (see [@sec:epsilon]), it's possible to manually translate the former into the latter and then use the `+` and `-` operators at will.

In the above example, the chances of an empty production are higher than those of `beautiful`.

# Static validation of grammars

*Polygen* features a powerful algorithm for statically checking the validity of a source file: it's therefore able to verify the correctness of a whole grammar in a finite amount of time, regardless of its complexity, without having to generate every possible production.

A source grammar that successfully passes the validation stage is guaranteed to always generate a valid output --- a proof of soundness of sorts.

Since the validation stage always precedes generation, if the program outputs without error messages then the grammar is entirely correct.

Within a message generated by the program, warnings and errors refer to the problematic area in the source text file by providing two pairs of coordinates, indicating its line- and column-number respectively.

## Errors

_Polygen_ classifies as errors those cases that violate the definition of grammtically correct.

An error halts the program execution.

### Undefined non-terminal symbols

The existence of each non-terminal symbol appearing in the right-hand side of a definition is checked in order to avoid the erroneous usage of undefined non-terminal symbols.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= A | B ;

A ::= a ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The above grammar generates an error message since `B` is not defined.

### Cyclic recursions and non-termination {#sec:cyclic-recursions}

The validation algorithm checks that every non-terminal symbol is able to produce an output --- i.e., that the generation will eventually terminate, without incurring in infinite recursion.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= S | A ;
A ::= B ;
B ::= S | A ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This grammar could never produce any output because --- regardless of the chosen initial non terminal symbol --- it would loop forever.

Some subtler cases --- trickier to detect ---  may lead to subcycles:

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a | A ;
A ::= B ;
B ::= A ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although the above grammar doesn't necessary incur in infinite recursion, due to the presence of the `a` terminal, a never-ending generation is still a possibility. Therefore, similar situations are reported as errors too.

### Recursive unfoldings {#sec:recursive-unfoldings}

You're not allowed to prefix the unfolding operator `>` (see [@sec:non-terminal-symbols]) to a non-terminal symbol that would cause a cyclic recursion.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >A ;
A ::= >B ;
B ::= >S ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Such a grammar would trigger a series of unfoldings that would expand it infinitely; therefore, it will generate an error message.

### Epsilon-productions {#sec:epsilon-productions}

In some cases a grammar might meet the termination clause through an epsilon-production (see [@sec:epsilon]) --- i.e., its only possible outcome is an empty production.

Such grammars are considered incorrect.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= A ;

A ::= A ^ | _ ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In some situations, also a selective destruction (see [@sec:destructive-selection]) could lead to an epsilon production.

### Overriding of non-terminal symbols

Grammars are checked to ensure that the same non-terminal symbol is not being defined more than once in the same scope.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A ::= apple | orange | banana ;

A ::= tangerine | melon ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The above grammar leads to an error since `A` is defined twice.

This also applies inside inserted scopes (see [@sec:environment-scoping]):

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= (A ::= apple | orange | banana ; A ::= tangerine | melon ; a ripe A) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Illegal character

This type of error is risen by the lexer when, during the syntactic analysis of the source file, it encounters a character not belonging to any known token --- i.e., not defined by the lexical rules of [@sec:lexical-rules].

### Unexpected token

This type of error is risen by the parser when, during the syntactic analysis of the source file, it encounters a misplaced, albeit valid, token --- i.e., its occurrence in a wrong position is a violation of the syntactical rules of [@sec:concrete-syntax].

## Warnings

Warnings embrace all those cases that do not violate the definition of grammatically correct but could lead to unexpected or undesired results. The presence of warning messages doesn't mean that the grammar is incorrect, but it does indicates that the grammar is not robust.

Warnings don't halt the program execution.

Warnings are divided into levels, according to their gravity: the lower the level, the higher the priority of the warnings belonging to it. Level 0 represents warnings that cannot be ignored (still, they don't pose a threat to the generation).

### Level 0

Currently, there are no warnings belonging to this level.

### Level 1

#### Undefined `I` symbol

Gammars lacking a definition for the non-terminal `I` symbol can't be queried with *Polygen*’s `-info` option.

The `I` symbol is usually employed to generate a description string about the grammar (its author, title, etc.); although its omission is not an error, it is highly recommended to follow this convention and provide a useful definition.

#### Potential epsilon-productions {#sec:potential-epsilon-productions}

In some cases, a grammar doesn't always generate an epsilon production (see [@sec:epsilon-productions]), but it could potentially do so.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= [a] ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Such cases are not errors, but they are notified by a warning message.

In some situations, also a selective destruction (see [@sec:destructive-selection]) could lead to a potential epsilon production.

#### Destructive Selection {#sec:destructive-selection}

In scenarios relying massively on labels selection (see [@sec:labels-selection]) it's not uncommon to loose track of their propagation and forget to activate them, or activate the wrong ones. The outcome is the destruction of the productions that depended on the activation of those label, with a resulting epsilon production.

The luckier cases, where the destruction affects a whole production, are regularly caught and addressed via a warning ([-@sec:potential-epsilon-productions]) or an error ([-@sec:epsilon-productions]). As for those cases in which the destroyed productions are inside a sequence, the validation algorithm has no way to detect the problem because, as a matter of fact, it wouldn't be dealing with an epsilon-production:

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a A.z ;

A ::= x: x | y: y ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When a destructive selection is detected, a specific warning is issued to inform the user about the problem. Bear in mind that, by fixing all the warning of this type, you'll increase the robustness of the grammar, and sometimes it might also help to detect coneptual misuses of the lables.

### Level 2

#### Useless permutation

In case just a single permutable subproduction appears within a sequence (see [@sec:permutation]), no permutation is actually performed (for obvious reasons).

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= a {b} c ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although this is not an actual error, it will still produce a low-priority warning message.

#### Useless unfolding

If the unfolding operator is used in contexts that --- albeit sound --- would not lead to any actual unfolding, a low-priority warning is generated.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >(b c) ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Trying to unfold a subproduction containing a single production is useless.

### Level 3

#### Unfolding a suspended symbol

Although unfolding a strongly bound symbol (see [@sec:suspensions]) is both sintactically legal and semantically correct, it raises some conceptual perplexity. Its outcome is somewhat similar to the concept of _inheratance_: inducing the preprocessor to replicate the productions bound to the suspended symbol, and then insert them flattened (see [@sec:non-terminal-symbols]) inside another production, is equivalent to _inheriting_ the productions of that symbol in order to have them generate something different.

**EXAMPLE**

!Polygen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S ::= >A A A ;

A := a | b ;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**PRODUCES**

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a a a
b a a
a b b
b b b
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This trick is regarded as a misuse of unfolding, and it's therefore reported with a warning of extremely low priority.

# Appendix

## Concrete syntax {#sec:concrete-syntax}

What follows is the concrete syntax, in *[EBNF]* notation, of the grammar definition language (*[Type-2]*) interpreted by *Polygen* and described in this document.

Non-terminal symbols bound to productions are in uppercase; non-terminal symbols bound to regular expressions are capitalized (see [@sec:lexical-rules]); terminal symbols are quoted; `S` is the starting non-terminal symbol.

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE "Concrete syntax" (EBNF Rules) from external file.
        (same file shared by all versions of the manual)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_inc_con.markdown)

## Abstract syntax

For the sake of completeness, here follows the abstract syntax of the language interpreted by *Polygen*, stripped of all syntactic sugars and any terms that pertain solely to the preprocessing stage (see [@sec:translation-rules] for the translation rules).

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE "Abstract syntax" (EBNF Rules) from external file.
        (same file shared by all versions of the manual)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_inc_abs.markdown)

## Lexical rules {#sec:lexical-rules}

Here follow the lexical rules in regular expression notation (*Type-3*).

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE "Lexical rules" (EBNF Rules) from external file.
        (same file shared by all versions of the manual)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_inc_lex.markdown)

Bear in mind that also the space character can used as terminal symbol within quotes.

## Escape sequences

The `Nonterm` regular expression of [@sec:lexical-rules] considers a backslash within quotes as the escape character. A terminal symbol within quotes may contain any of the following escape sequences:

|        |                          |
|--------|--------------------------|
| `\\`   | backslash                |
| `\"`   | quote                    |
| `\n`   | new line                 |
| `\r`   | carriage return          |
| `\b`   | backspace                |
| `\t`   | tab                      |
| `\xyz` | ASCII decimal code _xyz_ |

## Translation rules {#sec:translation-rules}

As a formal reference, we provide here the rules of translation from concrete- to abstract-syntax, in their order of precedence (where the _i_-th translation precedes the _i+1_-th). They refer to the operations performed by either the parser (in case of syntactic sugars) or the preprocessor (in all other cases).

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INCLUDE TABLES: 4.1.5 Translation rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!include(polygen-spec_EN_inc_tables.markdown)

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----------------------------{ END OF DOCUMENT }------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[GNU General Public License]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html "Visit the GNU GPLv2 homepage at www.gnu.org"

[Kleene closure]: https://it.wikipedia.org/wiki/Star_di_Kleene "View 'Kleene star' article on Wikipedia"

[Extended Backus Naur Form]: https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form "View 'Extended Backus–Naur form' article on Wikipedia"

[EBNF]: https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form "View 'Extended Backus–Naur form' article on Wikipedia"

[Type-2]: https://en.wikipedia.org/wiki/Chomsky_hierarchy#Type-2_grammars "View 'Chomsky hierarchy' article on Wikipedia"

[Tristano Ajmone]: https://github.com/tajmone "View Tristano Ajmone's GitHub profile"

!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                  CHANGELOG
==============================================================================
v1.1.0 (2018-02-10) | PML 1.0 | Polygen v1.0.6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

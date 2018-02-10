
!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Appendix: Concrete syntax (EBNF Rules)
------------------------------------------------------------------------
This block is locale-agnostic and is commonly shared by all versions of
the Polygen Manual. Include it via the !include(FILENAME) PP macro.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

!EBNF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
S      ::= DECLS

DECL   ::= Nonterm "::=" PRODS
        |  Nonterm ":=" PRODS

DECLS  ::= (DECL ";")+

PRODS  ::= PROD ("|" PROD)+

PROD   ::= ("+" | "-")* SEQ

LABELS ::= LABEL ("|" LABEL)*

LABEL  ::= ("+" | "-")* Label

SEQ    ::= [Label ":"] (ATOMS)+

ATOMS  ::= ATOM ("," ATOM)*

ATOM   ::= Term
        |  "^"
        |  "_"
        |  "\"
        |  UNFOLDABLE
        |  ">" UNFOLDABLE
        |  "<" UNFOLDABLE
        |  ATOM "."
        |  ATOM DotLabel
        |  ATOM ".(" LABELS ")"

UNFOLDABLE ::= Nonterm
        |      "(" SUB ")" ["+"]
        |      "[" SUB "]"
        |      "{" SUB "}"
        |      ">>" SUB "<<"

SUB ::= [DECLS] PRODS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

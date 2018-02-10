!comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Appendix: Abstract syntax (EBNF Rules)
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

PRODS  ::= SEQ ("|" SEQ)*

SEQ    ::= [Label ":"] (ATOM)+

ATOM   ::= Nonterm
        |  Term
        |  "^"
        |  "_"
        |  "(" SUB ")"
        |  ATOM "."
        |  ATOM DotLabel

SUB ::= [DECLS] PRODS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

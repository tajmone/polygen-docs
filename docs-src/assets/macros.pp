!comment(   pp-macros module   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"macros.pp v1.0.1 (2018-01-14) | PP v2.2.2

MACROS LIST:

-- !Polygen
-- !EBNF
--------------------------------------------------------------------------------
The PP macros herein contained were taken and redapted from:

 "The Pandoc-Goodies PP-Macros Library":
 -- https://github.com/tajmone/pandoc-goodies/tree/master/pp

(c) Tristano Ajmone 2017, MIT License.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment{   !Polygen                                         v1.0 | 2018-01-14 }
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Pass the Polygen code block in the parameter to André Simon's
            Highlight tool, and inject the syntax highlighted raw HTML into
            the source markdown document. Requires a shell env.

USAGE:

    !Polygen
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

NOTES: To disable Shell expansion of the sourcecode block (and errors when
       it contains backtick characters), the "EOF" delimiter string in the
       redirection operator is placed within single quotes:

           cat <<'EOF' |

       (see "Here Documents" for more info)
``````````````````````````````````````````````````````````````````````````````
!define(   Polygen   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<pre class="hl Polygen"><code class="Polygen">!sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat <<'EOF' | highlight -f --config-file=assets/polygen.lang --no-trailing-nl --validate-input
!1
EOF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</code></pre>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




!comment{   !EBNF                                            v1.0 | 2018-01-14 }
``````````````````````````````````````````````````````````````````````````````
DECRIPTION: Like the !Polygen macro, but uses our custom EBNF syntax instead.
            Required to highlight EBNF blocks in Appendix of Polygen manual.

USAGE:

    !EBNF
    ~~~~~~~~~~~~~~~~
    BLOCK OF SOURCECODE
    ~~~~~~~~~~~~~~~~

``````````````````````````````````````````````````````````````````````````````
!define(   EBNF   )
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<pre class="hl EBNF"><code class="EBNF">!sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat <<'EOF' | highlight -f --config-file=assets/ebnf2.lang --no-trailing-nl --validate-input
!1
EOF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</code></pre>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

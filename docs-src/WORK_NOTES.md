# Work Notes

Some notes for maintaninace of the _Polygen Meta Language Spec_ document.

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [Introduction](#introduction)
    - [Cross-References Usage](#cross-references-usage)
    - [Original Section Numbers](#original-section-numbers)
    - [List of Custom Labels Used](#list-of-custom-labels-used)
- [Italian Document](#italian-document)
    - [Original Section Numbers](#original-section-numbers-1)
    - [List of Custom Labels Used](#list-of-custom-labels-used-1)
- [English Document](#english-document)
    - [Original Section Numbers](#original-section-numbers-2)
    - [List of Custom Labels Used](#list-of-custom-labels-used-2)

<!-- /MarkdownTOC -->

-----

# Introduction

## Cross-References Usage

These document contains some work notes regarding `pandoc-crossref` filter labels used in the documents for internal cross referencing. For full details on how `pandoc-crossref` filter cross references work, see:

- http://lierdakil.github.io/pandoc-crossref/#section-labels

For each document language there is a section offering two tables:

- Original Section Numbers
- List of Custom Labels Used

## Original Section Numbers

The frist table lists the sections numbers of the original document, and the custom labels implemented to replace them in the new edition. Here is the meaning of its columns:

1. Section Number in original document (numbers have changed in new version)
2. Title of the section
3. Label given to the section

## List of Custom Labels Used

When adding new Section Labels, make sure their names are kept unique (some titles are similar, be careful when abridging them).

The second table provides an alphabetically sorted list of all Section Labels used in the document, before creating a new label consult it to make sure you'r not reusing an existing label Id.

Also useful for copy-&-paste operations.


# Italian Document 

## Original Section Numbers

For "OLD S.N.", refer to [original Italian document].


|  OLD S.N. |                        SECTION TITLE                         |                  LABEL                   |
|-----------|--------------------------------------------------------------|------------------------------------------|
| 1.0.2     | Sottoproduzioni opzionali                                    | `{#sec:sottoproduzioni-opzionali}`       |
| 2.0.2     | Epsilon                                                      | `{#sec:epsilon}`                         |
| 2.0.3     | Controllo della probabilità di una produzione                | `{#sec:controllo-probabilita}`           |
| 2.0.4     | Unfolding                                                    | `{#sec:unfolding}`                       |
| 2.0.4.1   | Di simboli non terminali                                     | `{#sec:simboli-non-terminali}`           |
| 2.0.4.2   | Di sottoproduzioni                                           | `{#sec:unfolding-sottoproduzioni}`       |
| 2.0.5.1   | Etichette e selezione                                        | `{#sec:etichette-selezione}`             |
| 2.0.7     | Permutazioni                                                 | `{#sec:permutazioni}`                    |
| 2.0.8     | Unfolding in profondità                                      | `{#sec:unfolding-profondita}`            |
| 2.0.10    | Binding                                                      | `{#sec:binding}`                         |
| 2.0.10.1  | Chiusure                                                     | `{#sec:chiusure}`                        |
| 2.0.10.2  | Sospensioni                                                  | `{#sec:sospensioni}`                     |
| 2.0.11    | Ambienti e Scoping                                           | `{#sec:ambienti-scoping}`                |
| 2.1.3     | Controllo della probabilità di una sottoproduzione opzionale | `{#sec:controllo-probabilita-opzionale}` |
| 3.0.1.3   | Unfolding ricorsivi                                          | `{#sec:unfolding-ricorsivi}`             |
| 3.0.1.4   | Epsilon-produzioni                                           | `{#sec:epsilon-produzioni}`              |
| 3.0.2.1.2 | Potenziali epsilon-produzioni                                | `{#sec:potenziali-epsilon-produzioni}`   |
| 3.0.2.1.3 | Selezione distruttiva                                        | `{#sec:selezione-distruttiva}`           |
| 4.1.1     | Sintassi concreta                                            | `{#sec:sintassi-concreta}`               |
| 4.1.3     | Regole lessicali                                             | `{#sec:regole-lessicali}`                |
| 4.1.5     | Regole di traduzione                                         | `{#sec:regole-traduzione}`               |


## List of Custom Labels Used


|                  LABEL                   |                   LINK                   |
|------------------------------------------|------------------------------------------|
| `{#sec:ambienti-scoping}`                | `[@sec:ambienti-scoping]`                |
| `{#sec:binding}`                         | `[@sec:binding]`                         |
| `{#sec:chiusure}`                        | `[@sec:chiusure]`                        |
| `{#sec:controllo-probabilita-opzionale}` | `[@sec:controllo-probabilita-opzionale]` |
| `{#sec:controllo-probabilita}`           | `[@sec:controllo-probabilita]`           |
| `{#sec:epsilon-produzioni}`              | `[@sec:epsilon-produzioni]`              |
| `{#sec:epsilon}`                         | `[@sec:epsilon]`                         |
| `{#sec:etichette-selezione}`             | `[@sec:etichette-selezione]`             |
| `{#sec:permutazioni}`                    | `[@sec:permutazioni]`                    |
| `{#sec:potenziali-epsilon-produzioni}`   | `[@sec:potenziali-epsilon-produzioni]`   |
| `{#sec:regole-lessicali}`                | `[@sec:regole-lessicali]`                |
| `{#sec:regole-traduzione}`               | `[@sec:regole-traduzione]`               |
| `{#sec:selezione-distruttiva}`           | `[@sec:selezione-distruttiva]`           |
| `{#sec:simboli-non-terminali}`           | `[@sec:simboli-non-terminali]`           |
| `{#sec:sintassi-concreta}`               | `[@sec:sintassi-concreta]`               |
| `{#sec:sospensioni}`                     | `[@sec:sospensioni]`                     |
| `{#sec:sottoproduzioni-opzionali}`       | `[@sec:sottoproduzioni-opzionali]`       |
| `{#sec:unfolding-profondita}`            | `[@sec:unfolding-profondita]`            |
| `{#sec:unfolding-ricorsivi}`             | `[@sec:unfolding-ricorsivi]`             |
| `{#sec:unfolding-sottoproduzioni}`       | `[@sec:unfolding-sottoproduzioni]`       |
| `{#sec:unfolding}`                       | `[@sec:unfolding]`                       |

# English Document 

## Original Section Numbers

For "OLD S.N.", refer to [original English document].

| OLD S.N. |                      SECTION TITLE                       |                    LABEL                    |
|----------|----------------------------------------------------------|---------------------------------------------|
| 1.0.2    | Optional subproductions                                  | `{#sec:optional-subproductions}`            |
| 2.0.2    | Epsilon                                                  | `{#sec:epsilon}`                            |
| 2.0.3    | Controlling the probability of a production              | `{#sec:controlling-probability-production}` |
| 2.0.4    | Unfolding                                                | `{#sec:unfolding}`                          |
| 2.0.4.1  | Non-terminal symbols                                     | `{#sec:non-terminal-symbols}`               |
| 2.0.4.2  | Subproductions                                           | `{#sec:unfolding-subproductions}`           |
| 2.0.4.3  | Optional subproductions                                  | `{#sec:unfolding-optional-subproductions}`  |
| 2.0.5.1  | Labels and selection                                     | `{#sec:labels-selection}`                   |
| 2.0.7    | Permutation                                              | `{#sec:permutation}`                        |
| 2.0.8    | Deep unfolding                                           | `{#sec:deep-unfolding}`                     |
| 2.0.10   | Binding                                                  | `{#sec:binding}`                            |
| 2.0.10.1 | Closures                                                 | `{#sec:closures}`                           |
| 2.0.10.2 | Suspensions                                              | `{#sec:suspensions}`                        |
| 2.0.11   | Environment and scoping                                  | `{#sec:environment-scoping}`                |
| 2.1.3    | Controlling the probability of an optional subproduction | `{#sec:controlling-probability-optional}`   |
| 3.0.1.2  | Cyclic recursions and non-termination                    | `{#sec:cyclic-recursions}`                  |
| 3.0.1.3  | Recursive unfoldings                                     | `{#sec:recursive-unfoldings}`               |
| 3.0.1.4  | Epsilon-productions                                      | `{#sec:epsilon-productions}`                |
| 3.0.2.2  | Potential epsilon-productions                            | `{#sec:potential-epsilon-productions}`      |
| 4.1.1    | Concrete syntax                                          | `{#sec:concrete-syntax}`                    |
| 4.1.3    | Lexical rules                                            | `{#sec:lexical-rules}`                      |
| 4.1.5    | Translation rules                                        | `{#sec:translation-rules}`                  |
| 4.2.2.3  | Destructive Selection                                    | `{#sec:destructive-selection}`              |



## List of Custom Labels Used

|                    LABEL                    |                     LINK                    |
|---------------------------------------------|---------------------------------------------|
| `{#sec:binding}`                            | `[@sec:binding]`                            |
| `{#sec:closures}`                           | `[@sec:closures]`                           |
| `{#sec:concrete-syntax}`                    | `[@sec:concrete-syntax]`                    |
| `{#sec:controlling-probability-optional}`   | `[@sec:controlling-probability-optional]`   |
| `{#sec:controlling-probability-production}` | `[@sec:controlling-probability-production]` |
| `{#sec:cyclic-recursions}`                  | `[@sec:cyclic-recursions]`                  |
| `{#sec:deep-unfolding}`                     | `[@sec:deep-unfolding]`                     |
| `{#sec:destructive-selection}`              | `[@sec:destructive-selection]`              |
| `{#sec:environment-scoping}`                | `[@sec:environment-scoping]`                |
| `{#sec:epsilon-productions}`                | `[@sec:epsilon-productions]`                |
| `{#sec:epsilon}`                            | `[@sec:epsilon]`                            |
| `{#sec:labels-selection}`                   | `[@sec:labels-selection]`                   |
| `{#sec:lexical-rules}`                      | `[@sec:lexical-rules]`                      |
| `{#sec:non-terminal-symbols}`               | `[@sec:non-terminal-symbols]`               |
| `{#sec:optional-subproductions}`            | `[@sec:optional-subproductions]`            |
| `{#sec:permutation}`                        | `[@sec:permutation]`                        |
| `{#sec:potential-epsilon-productions}`      | `[@sec:potential-epsilon-productions]`      |
| `{#sec:recursive-unfoldings}`               | `[@sec:recursive-unfoldings]`               |
| `{#sec:subproductions}`                     | `[@sec:subproductions]`                     |
| `{#sec:suspensions}`                        | `[@sec:suspensions]`                        |
| `{#sec:translation-rules}`                  | `[@sec:translation-rules]`                  |
| `{#sec:unfolding-optional-subproductions}`  | `[@sec:unfolding-optional-subproductions]`  |
| `{#sec:unfolding-subproductions}`           | `[@sec:unfolding-subproductions]`           |
| `{#sec:unfolding}`                          | `[@sec:unfolding]`                          |



  
[original Italian document]: ./original_Polygen-Refman_IT.html "View original Italian document"

[original English document]: ./original_Polygen-Refman_EN.html "View original English document"
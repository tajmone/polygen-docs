# Polygen Docs Work

Working folder for Polygen Documentation.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [Files List and Usage Notes](#files-list-and-usage-notes)
    - [Maintainers Notes](#maintainers-notes)
    - [Original Manuals](#original-manuals)
    - [Source Docs](#source-docs)
    - [Output Docs](#output-docs)
    - [Build Scripts](#build-scripts)
        - [Initializing The Work Environment](#initializing-the-work-environment)
        - [Building The Documents](#building-the-documents)
        - [Using The Watch Scripts](#using-the-watch-scripts)
    - [Assets and Tools](#assets-and-tools)
- [Requirements](#requirements)
    - [Third-Party Tools](#third-party-tools)
    - [Optional Third-Party Tools](#optional-third-party-tools)
- [Credits](#credits)

<!-- /MarkdownTOC -->

-----

# Files List and Usage Notes

A quick walkthrough the various files and how to use them.

> __NOTE__ — In order to distinguish between markdown files intended for GitHub previewing and pandoc markdown files (with PP macros), in these folders we'll adopt the following file extensions convention:
> 
> - "`*.md`" — GitHub flavored markdown (GFM)
> - "`*.markdown`" — [Pandoc] flavored markdown (with [PP] macros)

## Maintainers Notes

- [`WORK_NOTES.md`](./WORK_NOTES.md)

The `WORK_NOTES.md` file contains important notes that should be read by anyone willing to edit or update the existing docs with new contents, or by translators to new locales.

If you only need to build the documents, you can skip those.

## Original Manuals

The original Manuals being reprinted (now renamed to _Polygen Meta Language Spec_), written by [Alvise Spanò] (author of Polygen):

- [`original_Polygen-Refman_IT.html`](./original_Polygen-Refman_IT.html)
- [`original_Polygen-Refman_EN.html`](./original_Polygen-Refman_EN.html) (incomplete)

Used as references during the markdown porting stage. The original HTML files were cleaned-up using [HTML Tidy]; they were downloaded from:

- http://lapo.it/polygen/polygen-1.0.6-20040705-doc.zip 

## Source Docs

The markdown source files for Italian _Polygen Meta Language Spec_:

- [`polygen-spec_IT.markdown`](./polygen-spec_IT.markdown) — main Italian source file
    - [`polygen-spec_IT_inc_tables.markdown`](./polygen-spec_IT_inc_tables.markdown) — include file with "Translation Rules" tables (Appendix)

The markdown source files for English _Polygen Meta Language Spec_:

- [`polygen-spec_EN.markdown`](./polygen-spec_EN.markdown) — main English source file
    - [`polygen-spec_EN_inc_tables.markdown`](./polygen-spec_EN_inc_tables.markdown) — include file with "Translation Rules" tables (Appendix)

include files common to all versions of the manual (locale-agnostic):

- [`polygen-spec_inc_abs.markdown`](./polygen-spec_inc_abs.markdown)
- [`polygen-spec_inc_con.markdown`](./polygen-spec_inc_con.markdown)
- [`polygen-spec_inc_lex.markdown`](./polygen-spec_inc_lex.markdown)


The "Translation Rules" tables are kept in a separate include-file because of the excessive width of their rows. When editing these, you'll want to disable text wrapping in your code editor.

## Output Docs

The HTML converted documents:

- [`polygen-spec_IT.html`](./polygen-spec_IT.html) — converted Italian doc
- [`polygen-spec_EN.html`](./polygen-spec_EN.html) — converted English doc

## Build Scripts

These are the Bash scripts to convert the markdown source docs to html:

- [`init.sh`](./init.sh) — initiliaze work environment
- [`conv_IT.sh`](./conv_IT.sh) — convert Italian doc
- [`conv_EN.sh`](./conv_EN.sh) — convert English doc
- [`watch_IT.sh`](./watch_IT.sh) — watch and build Italian doc
- [`watch_EN.sh`](./watch_EN.sh) — watch and build English doc

> __NOTE__ — These scripts where written for Git Bash, the Bash terminal that ships with Git for Windows. Some commands in the scripts (or instructions) might be specific to Bash and need adjustments to be used in other \*nix shells.

### Initializing The Work Environment

Before using the conversion scripts, you must first initialize the working environment by sourcing the `init.sh` script. Open a Bash instance here and type:

``` bash
. init.sh
```

This is a one-time operation that will last as long as the Bash terminal is open. It will add to the `$PATH` the `/tools/` folder, so that all the required third-party tools become available to the current Shell and its scripts. No permanent changes are made to the system.

The `init.sh` script contains some checks that make it safe to run it more than once (calling it more than once won't have any further effects).

### Building The Documents

To convert the Italian document, open here a Bash terminal and type:

``` bash
. init.sh
./conv_IT.sh
```

It will create/update the `polygen-spec_IT.html` file.

For subsequent conversions within the same Bash instance, you won't need to type "`. init.sh`" again; just type:

``` bash
./conv_IT.sh
```

For the English documents just use the equivalent English scripts, same logic applies.

### Using The Watch Scripts

- [`watch_IT.sh`](./watch_IT.sh) — watch and build Italian sources
- [`watch_EN.sh`](./watch_EN.sh) — watch and build English sources

The watch scripts will check for changes in all markdown sources connected to a given language (and CSS assets too): every time you save a source doc the watch script will launch the conversion script for that language. If you're editing the CSS file via the Sass project, every time the Sass compiler updates the CSS assets the watch script will trigger the conversion scripts again. 

This is very useful, you'll only have to refresh the browser to update the output document and see the changes, without having to rerun any conversion script.

Furthermore, the watch scripts will also invoke `init.sh`, so you don't need to initialize the working environment before using them (but initialization is local to the script, and will be lost when the watch script exits).

> __NOTE__ — The watch scripts require Multiwatch (Node.js) to be installed on the system (see [Optional Third-Party Tools] section).

## Assets and Tools

Various files required for building the docs from markdown to html:

- [`/assets/`](./assets)
    + [`/sass/`](./assets/sass) — Sass modules folder
    + [`GitHub.html5`](./assets/GitHub.html5) — pandoc template
    + [`polygen.lang`](./assets/polygen.lang) — Polygen syntax for Highlight
    + [`ebnf2.lang`](./assets/ebnf2.lang) — EBNF syntax for Highlight
    + [`macros.pp`](./assets/macros.pp) — PP macros module.
    + [`polyman.css`](./assets/polyman.css) — Polygen docs CSS styles (built via Sass from `polyman.scss`)
    + [`polyman.scss`](./assets/polyman.scss) — main Sass source file

You shouldn't bother about these unless you actually want to change elements of the build toolchain.

Third party tools folder:

- [`/tools/`](./tools)

Tools required for building the docs. You only need to set them up once (see: [Third-Party Tools]).


# Requirements

The scripts for building the documents must be invoked from Bash — you should already have Bash for Windows installed with Git. The Bash requirement is due to some PP macros using Shell commands; in the future I'll fix the macros to make them work with both Shell and CMD (right now it's not on top of the priorities list).

## Third-Party Tools

In order to run the conversion scripts you'll need the following tools:

- [pandoc] v2.1
- [PP] v2.2.2
- [pandoc-crossref] v0.3.0.0
- [Highlight] v3.42

The tools version numbers in the list are the ones used for this project, and to avoid potential conflicts in the interactions between these tools, you're stronly advised to fetch those exact versions.

All these tools are small in size, and they're available as standalone packages, so you don't need to install them system wide. You can download them and unpack them in the [`tools`][tools] folder, where you'll also find a script that will automatically download and setup all these tools for you (see instructions in its [`README.md`][README] file).

Because PP precompiled binary is only available for `x86_64`, you'll need a 64-bit OS (or you'll have to compile it yourself for `x86`).

## Optional Third-Party Tools

In order to benefit from the `wacth_*.sh` scripts, you'll need to install the Multiwatch tool (Node.js):

- [Multiwatch NPM homepage]

Multiwatch requires Node.js to be installed on your system:

- [Node.js Website]

# Credits

The creation of Polygen documents reuses some third party resources, all comptabile with the GPLv2 license.

For a full list of credits, and their licenses, see:

- [`CREDITS.md`](./CREDITS.md)
- [`assets/LICENSE`](./assets/LICENSE)



[Alvise Spanò]: https://github.com/alvisespano "View Alvise Spanò's GitHub profile"


[tools]: ./tools/ "Go to 'tools' folder"
[README]: ./tools/README.md "View to 'tools' folder README file"

[Third-Party Tools]: #third-party-tools
[Optional Third-Party Tools]: #optional-third-party-tools


[pandoc]: http://pandoc.org/ "Visit pandoc website"
[PP]: http://cdsoft.fr/pp/ "Visit PP website"
[pandoc-crossref]: http://lierdakil.github.io/pandoc-crossref/ "Visit pandoc-crossref website"
[Highlight]: http://www.andre-simon.de/doku/highlight/en/highlight.php "Visit Highlight website"


[Multiwatch NPM homepage]: https://www.npmjs.com/package/multiwatch "Visit multiwatch page at NPM"
[Node.js Website]: https://nodejs.org/en/ "Visit Node.js website"

[HTML Tidy]: http://www.html-tidy.org/ "Visit HTML Tidy website"


# Polygen Docs Sources

Working folder for Polygen Documentation.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3,4" -->

- [Files List and Usage Notes](#files-list-and-usage-notes)
    - [Maintainers Notes](#maintainers-notes)
    - [Original Manuals](#original-manuals)
    - [Source Docs](#source-docs)
    - [Output Docs](#output-docs)
    - [Build Scripts](#build-scripts)
        - [Building The Documents](#building-the-documents)
        - [Using The Watch Scripts](#using-the-watch-scripts)
    - [Assets and Tools](#assets-and-tools)
        - [Build Environment Initializer](#build-environment-initializer)
- [Requirements](#requirements)
    - [Third-Party Tools](#third-party-tools)
    - [Optional Third-Party Tools](#optional-third-party-tools)
        - [Onchange](#onchange)
        - [Dart Sass](#dart-sass)
- [Credits](#credits)

<!-- /MarkdownTOC -->

-----

# Files List and Usage Notes

A quick walkthrough the various files and how to use them.

> __NOTE__ — In order to distinguish between markdown files intended for GitHub previewing and pandoc markdown files (with PP macros), in these folders we'll adopt the following file extensions convention:
>
> - `*.md` — GitHub flavored markdown (GFM)
> - `*.markdown` — [Pandoc] flavored markdown (with [PP] macros)

## Maintainers Notes

- [`WORK_NOTES.md`](./WORK_NOTES.md)

The `WORK_NOTES.md` file contains important notes that should be read by anyone willing to edit or update the existing docs with new contents, or by translators to new locales.

If you only need to build the documents, you can skip those.

## Original Manuals

The original Manuals being reprinted (now renamed to _Polygen Meta Language Spec_), written by [Alvise Spanò] (author of Polygen):

- [`original_Polygen-Refman_IT.html`](./original_Polygen-Refman_IT.html)
- [`original_Polygen-Refman_EN.html`](./original_Polygen-Refman_EN.html) (incomplete)

Used as references during the markdown porting stage.
The original HTML files were cleaned-up using [HTML Tidy]; they were downloaded from:

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


The "Translation Rules" tables are kept in a separate include-file because of the excessive width of their rows.
When editing these, you'll want to disable text wrapping in your code editor.

## Output Docs

The HTML converted documents:

- [`polygen-spec_IT.html`](./polygen-spec_IT.html) — converted Italian doc
- [`polygen-spec_EN.html`](./polygen-spec_EN.html) — converted English doc

## Build Scripts

These are the Bash scripts to convert the markdown source docs to html:

- [`convert.sh`][convert.sh] — convert Italian or/and English doc(s)
- [`watch_IT.sh`](./watch_IT.sh) — watch and build Italian doc
- [`watch_EN.sh`](./watch_EN.sh) — watch and build English doc

> __NOTE__ — These scripts where written for Git Bash, the Bash terminal that ships with Git for Windows.
> Some commands in the scripts (or instructions) might be specific to Windows' Bash and need adjustments to be used in other \*nix shells.
>
> If you encounter problems executing them under different OSs and/or have a solution to improve their cross-platform support, please [open an Issue] with your suggestions or create a pull request with your solution.


### Building The Documents

The repository now offers a unified script for converting the documents:

- [`convert.sh`][convert.sh]

The script accepts a single parameter: either the short-hand of a supported locale (`en`|`it`) or the `all` keyword (to build all available documents).
The script's command line syntax is:

    convert.sh <all|en|it>

To convert the Italian document, open the Bash terminal in this folder and type:

``` bash
./convert.sh it
```

which will create/update the `polygen-spec_IT.html` file.

To convert the English document, same as above but type `en` instead of the `it` parameter:

``` bash
./convert.sh en
```
which will create/update the `polygen-spec_EN.html` file.

And to build the document in all the available languages at once, use the `all` parameter instead:

``` bash
./convert.sh all
```

### Using The Watch Scripts

- [`watch_IT.sh`](./watch_IT.sh) — watch and build Italian sources
- [`watch_EN.sh`](./watch_EN.sh) — watch and build English sources

The watch scripts will check for changes in all markdown sources connected to a given language, as well as the CSS files: every time you save a source doc the watch script will launch the conversion script for that language.
If you're updating the CSS file via the Sass sources, every time the Sass compiler updates the CSS assets the watch script will trigger the conversion scripts again.

This is very useful, you'll only have to refresh the browser to update the output document and see the changes, without having to manually re-run any conversion script.


## Assets and Tools

Various files required for building the docs from markdown to html:

- [`/assets/`](./assets)
    + [`/sass/`](./assets/sass) — Sass modules folder
    + [`GitHub.html5`](./assets/GitHub.html5) — pandoc template
    + [`polygen.lang`](./assets/polygen.lang) — Polygen syntax for Highlight
    + [`ebnf2.lang`](./assets/ebnf2.lang) — EBNF syntax for Highlight
    + [`macros.pp`](./assets/macros.pp) — PP macros module.
    + [`polyman.css`][polyman.css] — Polygen docs CSS styles (built via Sass from `polyman.scss`)
    + [`polyman.scss`](./assets/polyman.scss) — main Sass source file

You shouldn't bother about these unless you actually want to change elements of the build toolchain.

Third party tools folder:

- [`tools/`][tools/]

Tools required for building the docs.
You only need to set them up once (see: _[Third-Party Tools]_ section).

### Build Environment Initializer

The following script is used internally by [`convert.sh`][convert.sh] to setup the working environment:

- [`init.sh`][init.sh]

It prepends the [`tools/`][tools/] folder to the `$PATH` environment variable, so that all the required third-party tools from that folder become available to the current Shell and its scripts, taking precedence over pre-existing system-wide versions of the same tools (i.e. over more recent versions of the tools, if present).

This is a one-time operation that will last as long as the Bash terminal is open.
The script contains some checks that make it safe to invoke it more than once (it simply won't have any further effects).
No permanent changes are made to the system.

You won't usually need to invoke this script in your working sessions, but you might want to do so if you're planning to tweak the conversion toolchain and carry out some tests.

This feature was designed mainly for the Windows OS, for which the repository offers a script to fetch the exact version of all the required third party tools to build the documentation (see: _[Third-Party Tools]_ section) in order to ensure that all developers use identical tools, thus preventing errors or differences in the generated HTML docs.

The script won't have any effect on OSs other than Windows, unless the end users has manually added to the [`tools/`][tools/] folder the required binaries.

> __NOTE__ — Early versions of this repository required end users to manually invoke [`init.sh`][init.sh] (once) before converting the documents.
> This is no longer the case.


# Requirements

The scripts for building the documents must be invoked from Bash — you should already have Bash for Windows installed with Git.
The Bash requirement is due to some PP macros using Shell commands; in the future I'll fix the macros to make them work with both Shell and CMD (right now it's not on top of the priorities list).

## Third-Party Tools

In order to run the conversion scripts you'll need the following tools:

- [pandoc] `v2.1`
- [PP] `v2.2.2`
- [pandoc-crossref] `v0.3.0.0`
- [Highlight] `v3.42`

The tools' version numbers in the list are the ones used for this project, and to avoid unneeded differences in the generated HTML docs, and potential conflicts, contributors to the project must use those exact versions.

All of these tools are small sized and available as standalone packages, so you don't need to install them system-wide: you can manually download and unpack them in the [`tools/`][tools/] folder.

Windows' users can run our [`tools/download.bat`][download.bat] batch script that will automatically download and set them up (for instructions see [`tools/README.md`][tools/README.md]).

Because the PP precompiled binary is only available for `x86_64`, you'll need a 64-bit OS (or you'll have to compile it yourself for `x86`).

## Optional Third-Party Tools

### Onchange

In order to benefit from the `wacth_*.sh` scripts, you'll need to install the __onchange__ tool (Node.js):

- [Onchange NPM homepage]

Onchange requires Node.js to be installed on your system:

- [Node.js Website]

The easiest way to install Node.js on Windows is to install the [Node.js Chocolatey Package] using the [Chocolatey GUI] package manager.


### Dart Sass

In order to build the [`assets/polyman.css`][polyman.css] stylesheet you'll need to install [Dart Sass] on your system.

The easiest way to install Dart Sass on Windows is to install the [Sass Chocolatey Package] using the [Chocolatey GUI] package manager.

> __NOTE__ — Early versions of this repository (`v1.1.0`) relied on [Ruby Sass], which reached its end of life in March 2019.
> We switched to [Dart Sass] in August 2020; so beware that if you checkout commits prior to the switch to Dart Sass the old `assets/SASS-BUILD.bat` and `assets/SASS-WATCH.bat` scripts won't work with the Dart implementation of Sass.


# Credits

The creation of Polygen documents reuses some third party resources, all compatible with the GPLv2 license.

For a full list of credits, and their licenses, see:

- [`CREDITS.md`](./CREDITS.md)
- [`assets/LICENSE`](./assets/LICENSE)

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[open an Issue]: https://github.com/tajmone/polygen-docs/issues/new/choose "Click here to open an Issue on the Polygen-Docs repository"

<!-- dependencies -->

[pandoc]: http://pandoc.org/ "Visit pandoc website"
[PP]: http://cdsoft.fr/pp/ "Visit PP website"
[pandoc-crossref]: http://lierdakil.github.io/pandoc-crossref/ "Visit pandoc-crossref website"
[Highlight]: http://www.andre-simon.de/doku/highlight/en/highlight.php "Visit Highlight website"

[Onchange NPM homepage]: https://www.npmjs.com/package/onchange "Visit onchange page at NPM"
[Node.js Website]: https://nodejs.org/en/ "Visit Node.js website"
[Node.js Chocolatey Package]: https://chocolatey.org/packages/nodejs "View the Node.js package at chocolatey.org"

[Dart Sass]: https://sass-lang.com/dart-sass "Learn more about Dart Sass at sass-lang.com"
[Ruby Sass]: https://sass-lang.com/ruby-sass "Learn more about Ruby Sass at sass-lang.com"
[Sass Chocolatey Package]: https://chocolatey.org/packages/sass "View the Sass package at chocolatey.org"
[Chocolatey GUI]: https://chocolatey.org/packages/ChocolateyGUI "View the Chocolatey GUI package at chocolatey.org"

<!-- misc 3rd party tools -->

[HTML Tidy]: http://www.html-tidy.org/ "Visit HTML Tidy website"

<!-- project files and folders -->

[convert.sh]: ./convert.sh "View script source"
[init.sh]: ./init.sh "View script source"
[polyman.css]: ./assets//polyman.css "View the stylesheet source files"
[tools/]: ./tools/ "Navigate to the 'tools/' folder"
[tools/README.md]: ./tools/README.md "View 'tools/README.md' file"
[download.bat]: ./tools/download.bat "View script source"

<!-- internal XRefs -->

[Third-Party Tools]: #third-party-tools
[Optional Third-Party Tools]: #optional-third-party-tools

<!-- people -->

[Alvise Spanò]: https://github.com/alvisespano "View Alvise Spanò's GitHub profile"

<!-- EOF -->

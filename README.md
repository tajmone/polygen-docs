[![GNU GPL v2 License][license badge]][LICENSE]&nbsp;
![PML Spec][pml badge]&nbsp;
![Repository Version][release badge]&nbsp;
![build status][travis badge]

# Polygen-Docs

- https://github.com/tajmone/polygen-docs

Welcome to `polygen-docs`, the "Polygen Documentation Revival" project.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3,4" -->

- [The Documents](#the-documents)
- [Project Contents](#project-contents)
- [About](#about)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Credits](#credits)
- [What's New](#whats-new)
    - [August/September 2020](#augustseptember-2020)
    - [January/February 2018](#januaryfebruary-2018)
- [Links](#links)

<!-- /MarkdownTOC -->

-----

# The Documents

The _Polygen Meta Language Spec_ (Live HTML preview links):

- [`polygen-spec_EN.html`][PML en HTML Preview] — English
- [`polygen-spec_IT.html`][PML it HTML Preview] — Italian


# Project Contents

- [`/archived/`](./archived) — archived copies of every document release.
- [`/docs-src/`](./docs-src) — markdown source files and build toolchain.
- [`CONTRIBUTING.md`][CONTRIBUTING] — Contributors' Guidelines.
- [`LICENSE`][LICENSE] — GNU GPLv2 license.
- [`polygen-spec_EN.html`](./polygen-spec_EN.html) — latest version of _PML Spec_ (English).
- [`polygen-spec_IT.html`](./polygen-spec_IT.html) — latest version of _PML Spec_ (Italian).
- [`validate.sh`][validate.sh] — (for contributors) validates code styles consistency of source files (requires [EClint]).


# About

The goal of this project is to gather all Polygen related documentation into a centralized repository for easier maintainance.
All documents are written in markdown and converted to HTML through a customized toolchain leveraging pandoc, PP macros, Highlight and pandoc-crossref.

The pre-existing Polygen manual has been republished under the new title _Polygen Meta Language Spec_.
The translation of the English manual is now complete, and both the Italian and English documents have been revised for this new edition.

This project is maintained by [Tristano Ajmone] and Polygen's author [Alvise Spanò].


# License

- [`LICENSE`][LICENSE]

The manuals are released under the same license of Polygen: GNU GPL version 2 (or above).


# Acknowledgments

Many thanks to [Riccardo Bastianini] for his great contribution in revising the text of the English edition and pointing out problematic code examples.


# Credits

The toolchain for the creation of Polygen documents reuses some third party resources, all comptabile with the GPLv2 license.

For a full list of credits, and their licenses, see:

- [`/docs-src/CREDITS.md`](./docs-src/CREDITS.md)
- [`/docs-src/assets/LICENSE`](./docs-src/assets/LICENSE)


# What's New

This section resumes the latest changes to the repository structure and its toolchain.
For a Changelog of the _PML Spec_ documents, see [`archived/README.md`][archived/README.md].

## August/September 2020

In preparation for the `v1.1.1` release of the documents, we've polished the repository and carried out some improvements:

- Documentation toolchain:
    + Updated the third party dependencies to their latest versions:
        * pandoc `v2.10.1`.
        * pandoccrossref `v0.3.7.0a`.
        * PP `v2.14.1`.
        * Highlight `v3.57`.
        * GitHub HTML5 Pandoc Template `v2.2`.
    + Switched from Ruby Sass to Dart Sass.
    + Replaced with [onchange] the defunct multiwatch tool.
    + Replaced the `conv_EN.sh` and `conv_IT.sh` scripts with [`convert.sh`][convert.sh], a unified builder taking as parameter a supported locale (`en`|`it`) or `all`.
- Repository improvements:
    + Enforced code styles consistency via [EditorConfig] settings.
    + Enabled Travis CI code styles validation of every commit and PR via [EClint].
    + Added [_Contributor's Guidelines_][CONTRIBUTING].

## January/February 2018

Creation of the repository and first release (`v1.1.0`) of the new _PML Spec_ documents, ported from HTML to Markdown sources.

The following third party tools versions are used to build the HTML documents:

- pandoc `v2.1`.
- pandoc-crossref `v0.3.0.0`.
- PP `v2.2.2`.
- Highlight `v3.42`.
- GitHub HTML5 Pandoc Template `v2.0`.



-------------------------------------------------------------------------------

# Links

- [Polygen repository]
- [Polygen Website]
- [Polygen Wiki in English]
- [Polygen Wiki in Italian]


<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[Polygen repository]: https://github.com/alvisespano/Polygen "Visit Polygen official GitHub repository"
[Polygen Website]: http://www.polygen.org "Visit Polygen official website at www.polygen.org"

[Polygen Wiki in English]: https://github.com/alvisespano/Polygen/wiki "Visit the English Polygen Wiki"
[Polygen Wiki in Italian]: https://github.com/tajmone/Polygen/wiki "Visit the Italian Polygen Wiki"

[PML en HTML Preview]: http://htmlpreview.github.io/?https://github.com/tajmone/polygen-docs/blob/master/polygen-spec_EN.html "Live HTML preview of 'Polygen Meta Language Spec' (English)"
[PML it HTML Preview]: http://htmlpreview.github.io/?https://github.com/tajmone/polygen-docs/blob/master/polygen-spec_IT.html "Live HTML preview of 'Polygen Meta Language Spec' (Italian)"

<!-- 3rd party tools -->

[EClint]: https://www.npmjs.com/package/eclint "Visit EClint home at NPM"
[EditorConfig]: https://editorconfig.org/ "Visit EditorConfig website"
[onchange]: https://www.npmjs.com/package/onchange "Visit onchange page at NPM"

<!-- project files and folders -->

[archived/README.md]: ./archived/README.md "See PML Spec CHANGELOG and archived releases"
[CONTRIBUTING]: ./CONTRIBUTING.md "Read the Contributors' Guidelines"
[LICENSE]: ./LICENSE "View GNU GPL version 2 license file"
[validate.sh]: ./validate.sh "View script source"
[convert.sh]: ./docs-src/convert.sh "View script source"

<!-- badges -->

[license badge]: https://img.shields.io/badge/license-GPLv2-00b5da.svg
[pml badge]: https://img.shields.io/badge/PML%20Spec-1.0-brightgreen "Polygen Meta Language Specification version 1.0"
[release badge]: https://img.shields.io/badge/release-1.1.1-brightgreen "HTML Docs edition v1.1.1 (2020-09-13)"
[travis badge]: https://travis-ci.com/tajmone/polygen-docs.svg?branch=master "Travis CI: code styles validation via EditorConfig"

<!-- people -->

[Alvise Spanò]: https://github.com/alvisespano "View Alvise Spanò's GitHub profile"
[Riccardo Bastianini]: https://github.com/RBastianini "View Riccardo Bastianini's GitHub profile"
[Tristano Ajmone]: https://github.com/tajmone "View Tristano Ajmone's GitHub profile"

<!-- EOF -->

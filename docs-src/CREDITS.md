# Credits

The creation of Polygen documents reuses some third party resources, all computable with the GPLv2 license.

This document provides detailed credits to all the third parties whose works are being used in this repository (in their original form or adapted) and summary copyright and license information about the resources.

The full license text of every third party asset can be found in:

- [`assets/LICENSE`](./assets/LICENSE)


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3,4" -->

- [Highlight Syntax Definitions](#highlight-syntax-definitions)
    - [Polygen Grammars Syntax](#polygen-grammars-syntax)
    - [EBNF2 Syntax](#ebnf2-syntax)
- [GitHub Pandoc HTML5 Template](#github-pandoc-html5-template)
    - [GitHub Markdown CSS](#github-markdown-css)
    - [Primer CSS](#primer-css)
- [Base16 Builder](#base16-builder)
    - [Base16 Monokai](#base16-monokai)
    - [Base16 London Tube](#base16-london-tube)
- [The Pandoc-Goodies PP-Macros Library](#the-pandoc-goodies-pp-macros-library)

<!-- /MarkdownTOC -->

-----

# Highlight Syntax Definitions

Some custom language definitions were created for syntax-highlighting Polygen manuals' code examples via André Simon's [Highlight] tool:

- [Polygen Grammars Syntax](#polygen-grammars-syntax)
- [EBNF2 Syntax](#ebnf2-syntax)

Both syntaxes were created by Tristano Ajmone and released into the public domain, and both have become part of the official Highlight distribution (since v3.42):

    Written by Tristano Ajmone:
        <tajmone@gmail.com>
        https://github.com/tajmone
    Released into the public domain according to the Unlicense terms:
        http://unlicense.org/

> __NOTE__ — although these two syntax definitions are now shipped with Highlight, we're including them here as standalone files just in order to make sure that these documents use the exact version intendended (i.e., in future editions of Highlight these definitions could be updated or tweaked).

## Polygen Grammars Syntax

- [`assets/polygen.lang`](./assets/polygen.lang)

Used for syntax highlighting Polygen grammar examples in the documents.

## EBNF2 Syntax

- [`assets/ebnf2.lang`](./assets/ebnf2.lang)

Used for syntax highlighting EBNF rules in Polygen Manual's Appendix.

Highlight's default EBNF/BNF definitions couldn't handle well the EBNF notation used in Polygen Manual, so this new EBNF syntax was created by tweaking "`polygen.lang`" to fit the task.

# GitHub Pandoc HTML5 Template

- [`assets/GitHub.html5`](./assets/GitHub.html5)

This is a modified version of a template I've created for the __[Pandoc-Goodies]__ project:

- https://github.com/tajmone/pandoc-goodies/tree/master/templates/html5/github

**GitHub HTML5 Panodc Template** is Copyright © Tristano Ajmone, 2017-2020, released under [The MIT License](https://github.com/tajmone/pandoc-goodies/blob/master/templates/html5/github/LICENSE) (MIT):

```
MIT License

Copyright (c) Tristano Ajmone, 2017-2020 (github.com/tajmone/pandoc-goodies)
Copyright (c) Sindre Sorhus <sindresorhus@gmail.com> (sindresorhus.com)
Copyright (c) 2017 GitHub Inc.

"GitHub Pandoc HTML5 Template" is Copyright (c) Tristano Ajmone, 2017-2020,
released under the MIT License (MIT); it contains readaptations of substantial
portions of the following third party softwares:

(1) "GitHub Markdown CSS", Copyright (c) Sindre Sorhus, MIT License (MIT).
(2) "Primer CSS", Copyright (c) 2016 GitHub Inc., MIT License (MIT).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```


This template is build on top of [Sindre Sorhus](https://github.com/sindresorhus)’ **GitHub Markdown CSS**, plus some CSS modules taken from [GitHub](https://github.com) Incorporation’s **Primer CSS**:

  - [GitHub Markdown CSS](https://sindresorhus.com/github-markdown-css)
  - [Primer-CSS](http://primercss.io/)

## GitHub Markdown CSS

**GitHub Markdown CSS** is Copyright © Sindre Sorhus, released under [The MIT License](https://github.com/sindresorhus/github-markdown-css/blob/gh-pages/readme.md) (MIT).

These template files are derivatives from **GitHub Markdown CSS**:

  - [`assets/sass/_github-markdown.scss`](./assets/sass/_github-markdown.scss) (adapted from [`github-markdown.css`](https://github.com/sindresorhus/github-markdown-css/blob/gh-pages/github-markdown.css))

## Primer CSS

**Primer CSS** is Copyright © 2016 GitHub Inc., released under [The MIT License](https://github.com/primer/primer-css/blob/master/LICENSE) (MIT).

These template files are derivatives from the **Primer CSS** project’s modules:

  - [`assets/sass/_github-markdown.scss`](./assets/sass/_github-markdown.scss) (borrows snippets from various Primer modules)
  - [`assets/sass/_alerts.scss`](./assets/sass/_alerts.scss) (adapted from [`flash.scss`](https://github.com/primer/primer/blob/master/modules/primer-alerts/lib/flash.scss))

# Base16 Builder

For the syntax highlight themes in this project, I've used the following color schemes from Chris Kempson's __[base16-builder]__ project:

- [Base16 Monokai](#Base16-monokai)
- [Base16 London Tube](#base16-london-tube)

Base16 Builder is released under the MIT License:

```
MIT License

Copyright (C) 2012 Chris Kempson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Base16 Monokai

- [`assets/sass/_base16-monokai.scss`](./assets/sass/_base16-monokai.scss)

For the syntax highlighting of Polygen grammars examples, I've used the "__Monokai__" color scheme by Wimer Hazenberg:

- https://www.monokai.nl

Ported from YAML to SCSS by Tristano Ajmone, based on the source file from Chris Kempson's __base16-builder__ project (MIT License):

- https://github.com/chriskempson/base16-builder/blob/master/schemes/monokai.yml

I've also added a few extra colors to the scheme's palette (based on other Monokai implementations).

## Base16 London Tube

- [`assets/sass/_highlight-ebnf.scss`](./assets/sass/_highlight-ebnf.scss)

For the syntax highlighting of EBNF rules, I've used some colors from the "__Base16 London Tube__" scheme, by Jan T. Sott:

 - https://github.com/chriskempson/base16-builder/blob/master/schemes/tube.yml

# The Pandoc-Goodies PP-Macros Library

- [`assets/macros.pp`](./assets/macros.pp)

The `macros.pp` module reuses some PP macros I had created for the "__The Pandoc-Goodies PP-Macros Library__" project:

- https://github.com/tajmone/pandoc-goodies/tree/master/pp/macros

The macros have been adapted to the needs of this project.

The original macros are released under MIT License:

```
MIT License

Copyright (c) 2017 Tristano Ajmone

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```


<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[Pandoc-Goodies]: https://github.com/tajmone/pandoc-goodies "Visit Pandoc-Goodies project on GitHub"

[Highlight]: http://www.andre-simon.de/doku/highlight/en/highlight.php "Visit Highlight website"

[base16-builder]: https://github.com/chriskempson/base16-builder/ "Visit Base16 Builder project on GitHub"

<!-- EOF -->

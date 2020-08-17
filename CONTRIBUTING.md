# Contributors' Guidelines

Contributions to the __[Polygen-Docs]__ project are much appreciated and most welcome.
Here are some guidelines on the different ways you might contribute to the project, and which standards to follow.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [How Can I Help?](#how-can-i-help)
    - [Improving the PML Documentation](#improving-the-pml-documentation)
    - [Translating the PML Specs](#translating-the-pml-specs)
    - [Helping Maintaining the Repository](#helping-maintaining-the-repository)
- [Code Style Conventions](#code-style-conventions)

<!-- /MarkdownTOC -->

-----

# How Can I Help?

The main areas of contribution are:

1. Improving the PML Specs documentation
2. Translating the PML Specs to other languages
3. Maintenance of the repository

## Improving the PML Documentation

While the PML Specs are determined by the Polygen application (and won't change unless Polygen is updated), there's always room for improvement in the PML documentation:

- Spotting typos in the text.
- Spotting errors in the examples and their productions.
- Improving readability of the document by better rephrasing.

You can point out any typos, errors or improvements by [opening an Issue], or by submitting the fixes yourself via a pull request.

## Translating the PML Specs

Needless to say, translating the PML Specs to new languages would be a great contribution.

Your new translation should fit-in with the current toolchain, which is based on pandoc markdown sources, and various commonly shared assets.
This might require some coordination with the maintainers, so we advise you to being by [opening an Issue] so we can coordinate efforts and allocate a dedicated development branch for your translation work.

## Helping Maintaining the Repository

If you're a developer and wish to contribute to the repository's maintenance, it would be much appreciated.
The project is not updated very frequently, so we can easily loose sight of how the toolchain dependencies are lagging behind their latest version, which means that there's a lot of work involved whenever we need to update the whole repository.

If you have any suggestions to improve this project, feel free to share your thoughts with us by [opening an Issue], or by creating a pull request.

-------------------------------------------------------------------------------

# Code Style Conventions

Before submitting a pull request, ensure that your edited files abide the code style conventions of this repository, as defined in the [`.editorconfig`][.editorconfig] settings.

Make sure you're editor/IDE supports [EditorConfig] — if it doesn't support it natively, look for a third party plug-in.
Once your editor/IDE is configured to support [EditorConfig], you won't need to do anything special, the editor should automatically pick the code conventions settings from the project.

Before creating a commit for a pull request, you should always validate your changes locally by running the [`validate.sh`][validate.sh] script found in the repository root (requires installing [EClint] via NPM).

If the validation script runs without errors, the changes are good to go, otherwise check the reported files for code styles inconsistencies and fix them.

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[opening an Issue]: https://github.com/tajmone/polygen-docs/issues/new/choose "Open a new Issue on this repository"

[Polygen-Docs]: https://github.com/tajmone/polygen-docs "Visit the 'polygen-docs' repository"

[EditorConfig]: https://editorconfig.org/ "Visit EditorConfig website"
[EClint]: https://www.npmjs.com/package/eclint "Visit EClint home at NPM"

[.editorconfig]: ./.editorconfig "View EditorConfig settings"
[validate.sh]: ./validate.sh "View script source"

<!-- EOF -->

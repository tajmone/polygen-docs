# Required Tools Folder

In this folder you can download and unpack all the required tools for building the Polygen documents.
(The `.gitignore` file in this folder is set to ignore everything except this README file)

All instructions were written for Windows x64.
If you're using another OS, visit the links provided in the [troubleshooting section] and download the appropriate files for your OS.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3,4" -->

- [Download Via Script](#download-via-script)
- [Manual Download](#manual-download)
    - [Pandoc v2.10.1](#pandoc-v2101)
    - [PP v2.14.1](#pp-v2141)
    - [pandoc-crossref v0.3.7.0a](#pandoc-crossref-v0370a)
    - [Highlight v3.57.1](#highlight-v3571)
- [Troubleshooting](#troubleshooting)

<!-- /MarkdownTOC -->

-----

# Download Via Script

If you have installed on your system [7-Zip] and [cURL], you can just run the following batch script:

- [`download.bat`](./download.bat)

The script will take care of everything: it will download to this folder all the tools as Zip files, and then extract from them all the required files.
The script won't make any changes to your system: nothing is written to the registry, and all files will be unpacked strictly in this folder.

The automated script is the preferred way to install these third party tools, as future versions of the script could also be used to update all tools to a newer version (if the need arises).
If you don't have [7-Zip] and [cURL] on your system, consider installing them.

If you'r looking for trusted precompiled cURL binaries for Windows, you can get them from [Viktor Szakáts]'s page.
Alternatively, you can use the [cURL Download Wizard].
If you want a quick fix for this task, just download this file (x64):

- https://bintray.com/vszakats/generic/download_file?file_path=curl-7.57.0-win64-mingw.7z

... unpack it here, and copy to this folder all the files found inside `curl-7.57.0-win64-mingw\bin\`.

# Manual Download

Here are the links and instructions for manually downloading and unpacking all the required third party tools.

## Pandoc v2.10.1

Download (64-bit only):

- https://github.com/jgm/pandoc/releases/download/2.10.1/pandoc-2.10.1-windows-x86_64.zip

Unpack its contents here, you'll see a new folder `pandoc-2.10.1`: just move here all of its contents.

## PP v2.14.1

Download (64-bit only):

- http://christophe.delord.free.fr/pp/archives/pp-win-2.14.1.7z

Just unpack its contents here.

## pandoc-crossref v0.3.7.0a

Download (64-bit only):

- https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.7.0a/pandoc-crossref-Windows-2.10.1.7z

Just unpack its contents here.

## Highlight v3.57.1

Download (64-bit):

- http://www.andre-simon.de/zip/highlight-3.57.1-x64.zip

Unpack its contents here, you'll see a new folder `highlight-3.57.1-x64`: just move here all of its contents.

# Troubleshooting

If any of the above link have become obsolete in time, or if the proposed files are nood suited for your PC, visit the homepages and repositories of the tools:

- [Pandoc wesbite]
- [Pandoc GitHub repository]
- [PP homepage]
- [PP GitHub repository]
- [Pandoc-crossref documentation]
- [Pandoc-crossref GitHub repository]
- [Highlight homepage]
- [Highlight GitLab repository]

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[Viktor Szakáts]: https://bintray.com/vszakats/generic/curl/ "Viktor Szakáts' cURL downloads page"
[7-Zip]: http://7-zip.org/ "Visit 7-Zip website"
[cURL]: https://curl.haxx.se/ "Visit cURL website"
[cURL Download Wizard]: https://curl.haxx.se/dlwiz/ "Go to the cURL Download Wizard page"


[pandoc Wesbite]: http://pandoc.org/ "Visit pandoc website"
[pandoc GitHub repository]: https://github.com/jgm/pandoc "Visit pandoc GitHub repository"

[PP Homepage]: http://cdsoft.fr/pp/ "Visit PP homepage"
[PP GitHub repository]: https://github.com/CDSoft/pp "Visit PP GitHub repository"

[pandoc-crossref documentation]: http://lierdakil.github.io/pandoc-crossref/ "Visit pandoc-crossref documentation"
[pandoc-crossref GitHub repository]: https://github.com/lierdakil/pandoc-crossref "Visit pandoc-crossref GitHub repository"

[Highlight Homepage]: http://www.andre-simon.de/doku/highlight/en/highlight.php "Visit Highlight homepage"
[Highlight GitLab repository]: https://gitlab.com/saalen/highlight "Visit Highlight GitLab repository"

[troubleshooting section]: #troubleshooting

<!-- EOF -->

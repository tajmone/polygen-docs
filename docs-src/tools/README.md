# Required Tools Folder

In this folder you can download and unpack all the required tools for building the Polygen documents. (The `.gitignore` file in this folder is set to ignore everything except this README file)

All instructions were written for Windows x64. If you're using another OS, visit the links provided in the [troubleshooting section] and download the appropriate files for your OS.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [Download Via Script](#download-via-script)
- [Manual Download](#manual-download)
    - [Pandoc v2.1](#pandoc-v21)
    - [PP v2.2.2](#pp-v222)
    - [pandoc-crossref v0.3.0.0](#pandoc-crossref-v0300)
    - [Highlight v3.42](#highlight-v342)
- [Troubleshooting](#troubleshooting)

<!-- /MarkdownTOC -->

-----

# Download Via Script

If you have installed on your system [7-Zip] and [cURL], you can just run the following batch script:

- [`download.bat`](./download.bat)

The script will take care of everything: it will download to this folder all the tools as Zip files, and then extract from them all the required files. The script won't make any changes to your system: nothing is written to the registry, and all files will be unpacked strictly in this folder. 

The automated script is the preferred way to install these third party tools, as future versions of the script could also be used to update all tools to a newer version (if the need arises). If you don't have [7-Zip] and [cURL] on your system, consider installing them.

If you'r looking for trusted precompiled cURL binaries for Windows, you can get them from [Viktor Szakáts]'s page. Alternatively, you can use the [cURL Download Wizard]. If you want a quick fix for this task, just download this file (x64):

- https://bintray.com/vszakats/generic/download_file?file_path=curl-7.57.0-win64-mingw.7z

... unpack it here, and copy to this folder all the files found inside `curl-7.57.0-win64-mingw\bin\`.

# Manual Download

Here are the links and instructions for manually downloading and unpacking all the required third party tools.

## Pandoc v2.1

Download (x32):

- https://github.com/jgm/pandoc/releases/download/2.1/pandoc-2.1-windows.zip

Unpack its contents here, you'll see a new folder `pandoc-2.1`: just move here all of its contents.

## PP v2.2.2

Download (x64 only):

- http://cdsoft.fr/pp/archives/pp-win-2.2.2.7z

Just unpack its contents here.


## pandoc-crossref v0.3.0.0

Download (x32):

- https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.0.0/windows-ghc8-pandoc2-0.zip

Just unpack its contents here.

## Highlight v3.42

Download (x64):

- http://www.andre-simon.de/zip/highlight-3.42-x64.zip

Unpack its contents here, you'll see a new folder `highlight-3.42-x64`: just move here all of its contents.

# Troubleshooting

If any of the above link have become obsolete in time, or if the proposed files are nood suited for your PC, visit the homepages and repositories of the tools:

- [Pandoc wesbite]
- [Pandoc GitHub repository]
- [PP homepage]
- [PP GitHub repository]
- [Pandoc-crossref documentation]
- [Pandoc-crossref GitHub repository]
- [Highlight homepage]
- [Highlight GitHub repository]


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
[Highlight GitHub repository]: https://github.com/andre-simon/highlight "Visit Highlight GitHub repository"

[troubleshooting section]: #troubleshooting
@ECHO OFF
:: "download.bat" | v1.2.0 | 2020/08/30
:: *****************************************************************************
:: *                                                                           *
:: *                 Third-Party Tools Auto-Downloader Script                  *
:: *                                                                           *
:: *                            by Tristano Ajmone                             *
:: *                                                                           *
:: *****************************************************************************
:: Downloads and unpacks here all required tools for building Polygen documents:
:: - pandoc v2.10.1 (x86_64)
:: - PP v2.14.1 (x86_64)
:: - pandoc-crossref v0.3.7.0a (x86)
:: - Highlight v3.57.1 (x86_64)
:: -----------------------------------------------------------------------------

SET PANDOC=https://github.com/jgm/pandoc/releases/download/2.10.1/pandoc-2.10.1-windows-x86_64.zip
SET PP=http://christophe.delord.free.fr/pp/archives/pp-win-2.14.1.7z
SET PANDOC_CROSSREF=https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.7.0a/pandoc-crossref-Windows-2.10.1.7z
SET HIGHLIGHT=http://www.andre-simon.de/zip/highlight-3.57.1-x64.zip

ECHO.
ECHO ********************************* [ START ] **********************************
ECHO.

ECHO ==============================================================================
ECHO Downloading Pandoc
ECHO ------------------------------------------------------------------------------
cURL -o pandoc.zip -L %PANDOC%
ECHO ------------------------------------------------------------------------------
ECHO Unpacking Pandoc
ECHO ------------------------------------------------------------------------------
7z e pandoc.zip *.exe -r -y

ECHO ==============================================================================
ECHO Downloading PP
ECHO ------------------------------------------------------------------------------
cURL -o pp.7z -L %PP%
ECHO ------------------------------------------------------------------------------
ECHO Unpacking PP
ECHO ------------------------------------------------------------------------------
7z e pp.7z *.exe -r -y

ECHO ==============================================================================
ECHO Downloading pandoc-crossref
ECHO ------------------------------------------------------------------------------
cURL -o pandoc-crossref.7z -L %PANDOC_CROSSREF%
ECHO ------------------------------------------------------------------------------
ECHO Unpacking pandoc-crossref
ECHO ------------------------------------------------------------------------------
7z e pandoc-crossref.7z *.exe -r -y

ECHO ==============================================================================
ECHO Downloading Highlight
ECHO ------------------------------------------------------------------------------
cURL -o Highlight.zip -L %HIGHLIGHT%
ECHO ------------------------------------------------------------------------------
ECHO Unpacking Highlight
ECHO ------------------------------------------------------------------------------
7z e Highlight.zip highlight.exe *.dll *.conf -r -y
7z e Highlight.zip -olangDefs *\langDefs\*.* -r -y
7z e Highlight.zip -othemes *\themes\*.* -r -y

ECHO.
ECHO ***********************************[ END ]************************************
ECHO.

EXIT /B

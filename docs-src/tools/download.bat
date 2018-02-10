@ECHO OFF
::   "download.bat" | v1.0 | 2018/01/10 
::   ******************************************************************************
::   *                                                                            *
::   *                  Third-Party Tools Auto-Downloader Script                  *
::   *                                                                            *
::   *                             by Tristano Ajmone                             *
::   *                                                                            *
::   ******************************************************************************
::   Downloads and unpacks here all required tools for building Polygen documents:
::   - pandoc v2.1 (x86)
::   - PP v2.2.2 (x86_64)
::   - pandoc-crossref v0.3.0.0 (x86)
::   - Highlight v3.42 (x86_64)
::   ------------------------------------------------------------------------------

SET PANDOC=https://github.com/jgm/pandoc/releases/download/2.1/pandoc-2.1-windows.zip
SET PP=http://cdsoft.fr/pp/archives/pp-win-2.2.2.7z
SET PANDOC_CROSSREF=https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.0.0/windows-ghc8-pandoc2-0.zip
SET HIGHLIGHT=http://www.andre-simon.de/zip/highlight-3.42-x64.zip

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
cURL -o pandoc-crossref.zip -L %PANDOC_CROSSREF%
ECHO ------------------------------------------------------------------------------
ECHO Unpacking pandoc-crossref
ECHO ------------------------------------------------------------------------------
7z e pandoc-crossref.zip *.exe -r -y

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

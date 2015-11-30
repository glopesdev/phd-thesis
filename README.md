# phd-thesis
The main body of the thesis in LaTeX

## Build environment (Windows)

Based on the instructions at:
http://tex.stackexchange.com/questions/43984/using-notepad-with-miktex-on-windows

1. Install Basic MiKTeX 2.9
2. Install SumatraPDF
3. Copy the batch file "miktex_to_latex.bat" to the [Notepad++ installation Path]
4. Install NppExec plugin
5. Open a TeX file on Notepad++, run with F6 and enter the following lines on the popup dialog:
NPP_SAVE
"<Path_to_bat_file>" "$(CURRENT_DIRECTORY)" "$(NAME_PART)" "$(NAME_PART).pdf"
6. Save script as PDFLaTeX
7. Assign Notepad++ plugin command

For SVG conversion:

1. Install Inkscape
2. Add Inkscape to PATH
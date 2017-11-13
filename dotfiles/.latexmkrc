# See `texdoc latexmk` for configuration documentation

# record the filenames that pdflatex depends on to a .fls file
$recorder = 1;

# -pdf (generate pdf by pdflatex)
$pdf_mode = 1;

# -f (force continued processing past errors)
$force_mode = 1;

# call pdflatex with -interaction set to nonstopmode, reinforcing force_mode setting
# %O refers to the latexmk-generation options, and %S to the source file
$pdflatex = 'pdflatex -interaction=nonstopmode %O %S';

# -pvc (preview document and continuously update.)
$preview_continuous_mode = 1;

# the documentation say this should start with 'start ...',
# meaning latexmk should fork the command, but that's the default anyway
$pdf_previewer = 'open -a TeXShop.app %O %S';

# delete .bbl file when cleaning
$bibtex_use = 2;

# biber assumes we're running XeLaTeX or LuaTeX on the backend by default,
# these --output-safechars(set) settings turn UTF-8 chars back into LaTeX macros
$biber = 'biber --output-safechars --output-safecharsset=full %O %S'

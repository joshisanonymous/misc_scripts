# This script compiles LaTeX documents with XeLaTeX and BibTeX, using knitr
# beforehand in cases where the document includes R code. For knitr, it accepts
# either .Rnw or .Rtex files.
#
# Usage: Provide one argument at the command line, which is the filename (without
# the file extension) or the path+filename in cases where the files are not in
# the current directory.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

# Check if the document needs knitting and which file extension
if (test-path -path "$($args[0]).Rnw")
  {
  rscript -e "library(knitr); knit('$($args[0]).Rnw')"
  }
elseif (test-path -path "$($args[0]).Rtex")
  {
  rscript -e "library(knitr); knit('$($args[0]).Rtex')"
  }

# Perform typical compilation
xelatex "$($args[0]).tex"
bibtex "$($args[0]).aux"
xelatex "$($args[0]).tex"
xelatex "$($args[0]).tex"
sumatrapdf "$($args[0]).pdf"

# This script compiles LaTeX documents with XeLaTeX and BibTeX, using knitr
# beforehand in cases where the document includes R code. For knitr, it accepts
# either .Rnw or .Rtex files.
#
# Usage: Provide one argument at the command line, which is the filename (without
# the file extension). N.b., the script must be run from the working directory.
#
# Dependencies: SumatraPDF
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

# Save the argument entered to a variable
$file = $args[0]

# Check if the document needs knitting and which file extension
if (test-path -path "$file.Rnw")
  {
  rscript -e "library(knitr); knit('$file.Rnw')"
  }
elseif (test-path -path "$file.Rtex")
  {
  rscript -e "library(knitr); knit('$file.Rtex')"
  }

# Perform typical compilation
xelatex "$file.tex"
bibtex "$file.aux"
xelatex "$file.tex"
xelatex "$file.tex"
sumatrapdf "$file.pdf"

# Ask the user if they want to delete files then act accordingly
$delete = read-host "Do you want to delete generated intermediary files? (y/n)"

# Cleanup
if (($delete -match "[yY]") -and (test-path -path "$file.Rnw"))
  {
  remove-item "$file.tex", "$file.out", "$file.blg", "$file.bbl", "$file.aux", "$file.log"
  remove-item "figure" -recurse
  }
elseif ($delete -match "[yY]")
  {
  remove-item "$file.out", "$file.blg", "$file.bbl", "$file.aux", "$file.log"
  remove-item "figure" -recurse
  }

write-host "All done!"

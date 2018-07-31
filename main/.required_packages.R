# To execute this script:
# Rscript --vanilla init.R

options(repos = structure(c(CRAN = "http://cran.cnr.berkeley.edu")))

cran_packages <- c(
  "devtools",
  "ggplot2",
  "cowplot",
  "data.table",
  "plyr",
  "dplyr",
  "lintr",
  "pryr",
  "Rcpp",
  "RcppArmadillo",
  "reshape2",
  "readr",
  "rmarkdown",
  "roxygen2",
  "tidyr"
  )

# GitHub is a bit weird since the package name can be different than the GitHub
# repo suffix. make sure the packages are in the same order for gh_packages and gh_repos
gh_packages <- c(
  "colorout" = "jalvesaq/colorout",
  "sleuth" = "pachterlab/sleuth"
  )

bioc_packages <- c(
  "GenomicFeatures",
  "AnnotationDbi",
  "DESeq2",
  "edgeR",
  "limma",
  "biomaRt",
  "GEOquery",
  "rhdf5"
  )

get_missing <- function(required) {
  installed <- utils::installed.packages()[, 1]
  return( required[!(required %in% installed)] )
}

########################################################################
# main
########################################################################

# CRAN
{
  cran_missing <- get_missing(cran_packages)
  if (length(cran_missing) > 0) {
    utils::install.packages(get_missing(cran_packages))
  }
}

# GitHub
{
  for (repo in get_missing(gh_packages)) {
    devtools::install_github(repo)
  }
}

# Bioconductor
{
  bioc_missing <- get_missing(bioc_packages)
  if ( length(bioc_missing) > 0 ) {
    source("http://bioconductor.org/biocLite.R")
    biocLite( bioc_missing )
  }
}

# qcbsRworkshops

[![Build Status](https://travis-ci.org/QCBSRworkshops/qcbsRworkshops.svg?branch=master)](https://travis-ci.org/QCBSRworkshops/qcbsRworkshops)

The goal of qcbsRworkshops :package: is to ease the development of the QCBS R workshops.


## Installation

You can install the development version of qcbsRworkshops with [remotes :package:](https://cran.r-project.org/web/packages/remotes/index.html):

``` r
install.packages("remotes")
remotes::install_github("QCBSRworkshops/qcbsRworkshops")
```

## Examples

Once installed, first load the library.

``` r
library(qcbsRworkshops)
```

Then, there are two options:

1. the sources of the workshop are already in your computer, then use:

``` r
# if the workshop folder is the current directory (preferred), then use
build_workshop()
# if the path to the workshop folder is "path2workshop", then use
build_workshop("path2workshop")
```

2. the sources of a the workshop must be downloaded (a zip file will be downloaded):

``` r
build_workshops(download = TRUE, id = 1)
```


## Contributor Code of Conduct

Please note that the 'qcbsRworkshops' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

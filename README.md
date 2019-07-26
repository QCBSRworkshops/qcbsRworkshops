# qcbsRworkshops

[![Build Status](https://travis-ci.org/QCBSRworkshops/qcbsRworkshops.svg?branch=master)](https://travis-ci.org/QCBSRworkshops/qcbsRworkshops)

The goal of qcbsRworkshops :package: is to ease the development of the QCBS R workshops.


## Installation

You can install the development version of qcbsRworkshops with [remotes :package:](https://cran.r-project.org/web/packages/remotes/index.html):

``` r
install.packages("remotes")
remotes::install_github("QCBSRworkshops/qcbsRworkshops")
```

Once installed, you can load the package:

``` r
library(qcbsRworkshops)
```

## How to

### Build workshops

There are two options:

1. the sources of the workshop are already in your computer, then use:

``` r
# if the workshop folder is the current directory (preferred), then use
build_workshops()
# if the path to the workshop folder is "path2workshop", then use
build_workshops("path2workshop")
```

2. the sources of a the workshop must be downloaded (a zip file will be downloaded):

``` r
build_workshops(download = TRUE, id = 1)
```

### Clean workshops

To clean up cache and files created during the build, use

``` r
# if the workshop folder is the current directory (preferred), then use
clean_workshops()
# if the path to the workshop folder is "path2workshop", then use
build_workshops("path2workshop")
```

### Update template

To update the template (see https://github.com/QCBSRworkshops/templateWorkshops), use

``` r
# if the workshop folder is the current directory (preferred), then use
update_template()
# if the path to the workshop folder is "path2workshop", then use
update_template("path2workshop")
```



## Contributor Code of Conduct

Please note that the 'qcbsRworkshops' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

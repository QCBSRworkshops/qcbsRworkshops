# qcbsRworkshops

[![R build status](https://github.com/QCBSRworkshops/qcbsRworkshops/workflows/R-CMD-check/badge.svg)](https://github.com/QCBSRworkshops/qcbsRworkshops/actions)
[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)


The goal of the qcbsRworkshops :package: is to ease the development and editions of the QCBS R workshops.


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

### Extract R code

[knitr](https://yihui.name/knitr/) provides a nice function that extract R code from all code chunk and this :package: has a wrapper to extract the code for all the workshops in your working directory.

``` r
extract_Rcode_workshops("path2workshop")
```

### Presenter email

`mail_workshop()` generates emails te be sent to participants ~2 weeks before
the workshop. Just add your name and the details and an email will be generated
that you can copy-paste.

``` r
mail_workshop(7, pres_name = "Kevin Cazelles", lang = "both",
   details_fr = "à l'UdeM, salle A-2553, campus MIL, le vendredi 28 Février 2020 de 13h à 17h",
   details_en = "at the UdeM, MIL campus, room A-2553, on Friday February 28th 2020, 1pm-5pm"
)
```


## Contributor Code of Conduct

Please note that the 'qcbsRworkshops' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

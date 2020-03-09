#' qcbsRworkshops
#'
#' Set of helper functions to ease contribution to QCBS R workshops.
#'
#' @docType package
#' @name qcbsRworkshops
#' @keywords internal
#'
#' @importFrom crayon blue green
#' @importFrom glue glue
#' @importFrom clipr write_clip
#' @importFrom knitr purl
#' @importFrom pagedown chrome_print
#' @importFrom remotes install_github install_deps
#' @importFrom rmarkdown render
#' @importFrom tools md5sum
#' @importFrom utils download.file install.packages unzip
#' @importFrom yaml read_yaml

"_PACKAGE"


baseURL <- function() "https://github.com/QCBSRworkshops"
qcbstemplate <- function() "/templateWorkshops/archive/master.zip"
template_files <- function(path) {
  paste(rep(path, each = 4),
    c("qcbsR-fonts.css","qcbsR-header.html","qcbsR-macros.js","qcbsR.css"),
    sep="/")
}


download_template <- function(verbose = FALSE) {
  f <- tempfile(tmpdir = ".", fileext = ".zip")
  download.file(paste0(baseURL(), qcbstemplate()), f, quiet = !verbose)
  unzip(f, exdir = ".")
  unlink(f)
  invisible(NULL)
  ##
}

compare_copy_files <- function(fl1, fl2, verbose = TRUE) {
  if (file.exists(fl2)) {
    out <- md5sum(fl1) == md5sum(fl2)
    if (!out) {
      file.copy(fl1, fl2, overwrite = TRUE)
      if (verbose) success_msg("'", fl2, "' successfully updated!")
    } else success_msg(fl2, " already up to date!")
  } else {
    file.copy(fl1, fl2)
    if (verbose) success_msg("'", fl2, "' successfully updated!")
    out <- NULL
  }
  invisible(out)
}

find_f <- function(path = ".", pattern) list.files(path = path, pattern =
  pattern, recursive = TRUE, full.names = TRUE)

find_d <- function(path = ".", pattern) {
  ld <- list.dirs(path = path, recursive = TRUE, full.names = TRUE)
  ld[grepl(pattern, ld)]
}

ghurl <- function(id)
  sprintf(paste0(baseURL(), "/workshop%02d/archive/dev.zip"), as.numeric(id))

success_msg <- function(...) {
  message(green(paste0(cli::symbol$tick, " ", ...)))
}

info_msg <- function(...)
  message(blue(paste0(cli::symbol$info, " ", ...)))


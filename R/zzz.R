#' qcbsRworkshops
#'
#' Set of helper functions to ease contribution to QCBS R workshops.
#'
#' @docType package
#' @name qcbsRworkshops
#' @keywords internal
#' @importFrom tools md5sum
"_PACKAGE"


baseURL <- function() "https://github.com/QCBSRworkshops"
qcbstemplate <- function() "/templateWorkshops/archive/master.zip"



download_template <- function(verbose = FALSE) {
  f <- tempfile(tmpdir = ".", fileext = ".zip")
  download.file(paste0(baseURL(), qcbstemplate()), f, quiet = !verbose)
  unzip(f, exdir = ".")
  unlink(f)
  invisible(NULL)
  ##
}

compare_copy_files <- function(fl1, fl2, verbose = TRUE) {
  out <- md5sum(fl1) == md5sum(fl2)
  if (!out) {
    file.copy(fl1, fl2, overwrite = TRUE)
    if (verbose) message("'", fl2, "' successfully updated!")
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

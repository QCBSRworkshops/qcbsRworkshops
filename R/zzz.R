#' qcbsRworkshops
#'
#' Set of helper functions to ease contribution to QCBS R workshops.
#'
#' @docType package
#' @name qcbsRworkshops
#' @keywords internal
#'
#' @importFrom crayon blue green red yellow 
#' @importFrom glue glue
#' @importFrom clipr write_clip
#' @importFrom knitr purl
#' @importFrom pagedown chrome_print
#' @importFrom remotes install_github install_deps
#' @importFrom rmarkdown render
#' @importFrom tools md5sum
#' @importFrom utils download.file install.packages unzip
#' @importFrom yaml read_yaml
#' @importFrom fs path_package

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
      if (verbose) msgSuccess("'", fl2, "' successfully updated!")
    } else msgSuccess(fl2, " already up to date!")
  } else {
    file.copy(fl1, fl2)
    if (verbose) msgSuccess("'", fl2, "' successfully updated!")
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

 
# see package usethis (find_template()) for a much better version of this 
# as I just needed to use files without any changes, I made it simpler. 
add_file <- function(file_name, file = NULL, force = FALSE, pre = "") {
  path <- tryCatch(
    path_package(package = "qcbsRworkshops", "files", file_name),
    error = function(e) ""
  )
  if (identical(path, "")) {
    msgError(file_name, "not found.")
    stop()
  }
  
  fl <- paste0(pre, file_name)
  if (file.exists(fl)) {
    if (force) {
      msgWarning("remove", fl)
      file.remove(fl)
    } else {
       msgWarning("skipped", fl, 
        "already exists (use `force = TRUE` to overwrite it)")
      return(invisible(FALSE))
     }
  }
  cat(paste(readLines(path, encoding = "UTF-8"), collapse = "\n"), 
    file = fl)
  msgSuccess(fl, "added")
  return(invisible(TRUE))
}


## Message functions 

msgInfo <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt), appendLF = appendLF)
  invisible(txt)
}

msgError <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$cross, ...)
  message(red(txt), appendLF = appendLF)
  invisible(txt)
}

msgSuccess <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$tick, ...)
  message(green(txt), appendLF = appendLF)
  invisible(txt)
}

msgWarning <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$warning, ...)
  message(yellow(txt), appendLF = appendLF)
  invisible(txt)
}

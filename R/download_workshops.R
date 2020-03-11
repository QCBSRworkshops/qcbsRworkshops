#' Download workshops
#'
#' Download a selection of workshops.
#'
#' @param path path where the workshops files are or a path to a folder where the files will be extracted if download is set to `TRUE`.
#' @param ids workshop identifiers.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export
#'
#' @examples
#' download_workshops(1)

download_workshops <- function(ids, path = ".", verbose = TRUE) {
  lapply(
    ids,
    function(x) download_workshop_indiv(x, path = path, verbose = verbose)
  )
  invisible(NULL)
}


download_workshop_indiv <- function(id, path, verbose) {
  f <- tempfile(tmpdir = ".", fileext = ".zip")
  download.file(ghurl(id), f, quiet = !verbose)
  unzip(f, exdir = path)
  unlink(f)
  invisible(NULL)
}

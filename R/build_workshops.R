#' Render workshops
#'
#' Render the workshops and download the source files if requested.
#'
#' @param path path where the workshops files are or a path to a folder where the files will be extracted if download is set to `TRUE`.
#' @param download a logical. Should the workshop source files be downloaded? Default set to `FALSE`, it `TRUE` then `id` must be specified.
#' @param id workshops identifier.
#' @param Rmdfiles R Markdown source files, if `NULL` (default) then
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @importFrom utils unzip
#'
#' @export

build_workshops <- function(path = ".", download = FALSE, id = NULL, Rmdfiles = NULL, verbose = TRUE) {

  if (download) {
    if (is.null(id)) stop("`id` must be specified!")
    if (!dir.exists(path)) dir.create(path)
    path2 <- tempfile(tmpdir = path)
    download_workshop(id, path2, verbose)
    Rmdfiles <- find_f(path2, "^workshop.*[Rr]md$")
  } else if (is.null(Rmdfiles)) Rmdfiles <- find_f(path, "^workshop.*[Rr]md$")

  install_workshops_pkgs(find_f(path, "^pkgs.yaml$"), verbose = verbose)
  if (!length(Rmdfiles)) stop("No source file found")

  render_workshops(Rmdfiles, verbose = verbose)
  message(crayon::green(cli::symbol$tick, " Workshops successfully rendered."))

  invisible(NULL)
}


download_workshop <- function(id, path, verbose) {
  f <- tempfile(tmpdir = ".")
  download.file(ghurl(id), f, quiet = !verbose)
  unzip(f, exdir = path)
  unlink(f)
  invisible(NULL)
}

find_f <- function(path = ".", pattern) list.files(path = path, pattern =
  pattern, recursive = TRUE, full.names = TRUE)

ghurl <- function(id)
  sprintf("https://github.com/QCBSRworkshops/workshop%02d/archive/dev.zip", id)

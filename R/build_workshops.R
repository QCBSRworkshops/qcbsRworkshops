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
#' @export

build_workshops <- function(path = ".", download = FALSE, id = NULL, Rmdfiles = NULL, verbose = TRUE) {

  if (download) {
    if (is.null(id)) stop("`id` must be specified!")
    if (!dir.exists(path)) dir.create(path)
    path2 <- tempfile(tmpdir = path)
    download_workshop_indiv(id, path2, verbose)
    Rmdfiles <- find_f(path2, "^workshop.*[Rr]md$")
  } else if (is.null(Rmdfiles)) Rmdfiles <- find_f(path, "^workshop.*[Rr]md$")

  install_workshops_pkgs(find_f(path, "^pkgs.yaml$"), verbose = verbose)
  if (!length(Rmdfiles)) stop("No source file found")

  render_workshops(Rmdfiles, verbose = verbose)
  message(crayon::green(cli::symbol$tick, " Workshops successfully rendered."))

  invisible(NULL)
}

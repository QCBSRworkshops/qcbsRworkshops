#' Render workshops
#'
#' Render the workshops and download the source files if requested.
#'
#' @param path path where the workshops files are or a path to a folder where the files will be extracted if download is set to `TRUE`.
#' @param download a logical. Should the workshop source files be downloaded? Default set to `FALSE`, it `TRUE` then `id` must be specified.
#' @param id workshops identifier.
#' @param Rmdfiles R Markdown source files, if `NULL` (default) then, files will be searched for in the current directory.
#' @param update_template Should the template files be updated. Note that if these files are missing then they will be downloaded.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export

build_workshops <- function(path = ".", download = FALSE, id = NULL, Rmdfiles = NULL, update_template = FALSE, verbose = TRUE) {

  if (download) {
    if (is.null(id)) stop("`id` must be specified!")
    if (!dir.exists(path)) dir.create(path)
    path2 <- tempfile(tmpdir = path)
    download_workshop_indiv(id, path2, verbose)
    Rmdfiles <- find_f(path2, "^workshop.*[Rr]md$")
  } else if (is.null(Rmdfiles)) Rmdfiles <- find_f(path, "^workshop.*[Rr]md$")

  if (!length(Rmdfiles)) stop("No source file found")

  install_workshops_pkgs(find_f(path, "^pkgs.yaml$"), verbose = verbose)

  t_files <- list.files(path, pattern = "^qcbsR.*[ls]$", full.names = TRUE)
  if (!all(template_files() %in% t_files | update_template))
    update_template(path, verbose = verbose)

  render_workshops(Rmdfiles, verbose = verbose)
  message(crayon::green(
    paste0(cli::symbol$tick, " Workshop", gsub(".*/", "", Rmdfiles),
      " successfully rendered.\n")
    )
  )

  invisible(NULL)
}

#' Render workshops
#'
#' Render the workshops and download the source files if requested.
#'
#' @param path path where the workshops files are or a path to a folder where the files will be extracted if download is set to `TRUE`.
#' @param download a logical. Should the workshop source files be downloaded? Default set to `FALSE`, it `TRUE` then `id` must be specified.
#' @param id workshops identifier.
#' @param lang language of workshop, either "both" (default), "en" (English) or 
#' "fr" (French).
#' @param Rmdfiles R Markdown source files, if `NULL` (default) then, files will be searched for in the current directory.
#' @param update_template a logical. Should the template files be updated. Note that if these files are missing then they will be downloaded.
#' @param pdf a logical. Should a pdf version of the template be produced?
#' @param script a logical. Should the R script be extracted?
#' @param upgrade One of "default", "ask", "always", or "never". "default", see 
#' [remotes::install_deps()] for
#'  further details.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export

build_workshops <- function(path = ".", download = FALSE, id = NULL, 
  lang = c("both", "en", "fr"), Rmdfiles = NULL, update_template = FALSE, 
  pdf = FALSE, script = FALSE, upgrade = "never", verbose = TRUE) {
    
    
  lang <- match.arg(lang) 
  if (lang == "both") lang <- "[ef][nr]"
  rx <- paste0("^workshop[0-9]{2}-", lang, "\\.[Rr]md$")

  if (download) {
    if (is.null(id)) stop("`id` must be specified!")
    if (!dir.exists(path)) dir.create(path)
    path2 <- tempfile(tmpdir = path)
    download_workshop_indiv(id, path2, verbose)
    Rmdfiles <- find_f(path2, rx)
  } else {
    if (is.null(Rmdfiles))
      Rmdfiles <- find_f(path, rx)
  }
  if (!length(Rmdfiles)) stop("No source file found!")

  if (length(find_f(path, "^pkgs.yaml$"))) {
      install_workshops_pkgs(find_f(path, "^pkgs.yaml$"), verbose = verbose)
  }
  ## New way to install packages using remotes
  install_workshops_pkgs_remotes(path, upgrade = "never")

  # check/update template files
  path2 <- gsub("/[^/]*$", "", Rmdfiles)
  t_files <- find_f(path, "^qcbsR.*[msj][ls]$")
  if (!all(template_files(path2) %in% t_files) | update_template)
    update_template(path, verbose = verbose)

  render_workshops(Rmdfiles, verbose = verbose)
  msgSuccess(
    paste0(paste(gsub(".*/", "", Rmdfiles), collapse = ", "),
    " successfully rendered."))

  if (pdf) {
    msgInfo("converting html files to pdf")
    html <- gsub("\\.[Rr]md$", "\\.html", Rmdfiles)
    lapply(html, chrome_print)
    msgSuccess(paste0("PDF file", ifelse(length(html) > 1, "s", ""),
     " successfully created."))
  }
  if (script) {
    msgInfo("extracting R code from the R Markdown files")
    extract_Rcode_workshops(path, verbose = FALSE)
    msgSuccess(paste0("R script", ifelse(length(Rmdfiles) > 1, "s", ""),
     " successfully created."))
  }

  invisible(NULL)
}

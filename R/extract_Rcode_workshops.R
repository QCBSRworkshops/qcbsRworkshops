#' Extract R code
#'
#' Extract R code from workshops RMarkdown files.
#'
#' @param path path to a folder containing one or more workshops. 
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export

extract_Rcode_workshops <- function(path = ".", verbose = TRUE) {

  Rmdfiles <- find_f(path, "^workshop.*[Rr]md$")
  lapply(Rmdfiles, purl)

  invisible(NULL)
}

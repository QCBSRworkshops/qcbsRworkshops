#' Extract R code
#'
#' Extract R code from workshops R Markdown files.
#'
#' @param path path to a folder containing one or more workshops.
#' @param verbose a logical. Should extra information be reported on
#' progress?
#'
#' @export

extract_Rcode_workshops <- function(path = ".", verbose = TRUE) {

  rx <- "^workshop[0-9]{2}-[ef][nr]\\.[Rr]md$"

  Rmdfiles <- find_f(path, rx)
  lapply(Rmdfiles, function(x) purl(x,
      output = sub("\\.[Rr]md$", ".R", x), quiet = !verbose))

  invisible(NULL)
}

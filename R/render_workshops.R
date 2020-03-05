#' Render workshops
#'
#' Convert R Markdown files to HTML presentations.
#'
#' @param files path to the workshops' Rmd file(s) to be rendered.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export

render_workshops <- function(files, verbose = TRUE) {
  lapply(files, function(x) {
    render(x, quiet = !verbose)
  })
  invisible(NULL)
}

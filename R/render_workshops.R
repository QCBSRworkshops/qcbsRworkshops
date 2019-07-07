#' Render workshops
#'
#' @param files path to the workshops to be rendered.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @importFrom rmarkdown render
#'
#' @export

render_workshops <- function(files, verbose = TRUE) {
  lapply(files, function(x) render(x, quiet = !verbose))
  invisible(NULL)
}

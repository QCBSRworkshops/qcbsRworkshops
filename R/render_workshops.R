#' Render workshops
#'
#' @param files path to the workshops to be rendered.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export

render_workshops <- function(files, verbose = TRUE) {
  lapply(files, function(x) rmarkdown::render(x, quiet = !verbose))
  invisible(NULL)
}

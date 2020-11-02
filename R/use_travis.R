#' Add travis CI configuration file.
#'
#' @param force a logical. 
#'
#' @export

use_travis <- function(force = FALSE) {
  out <- add_file("travis.yml", force = force, pre = ".")
  invisible(out)
}
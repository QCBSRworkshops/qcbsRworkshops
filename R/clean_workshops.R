#' Clean up workshop folder
#'
#' Remove workshop files and clear cache.
#'
#' @param path path where the workshops files are to be cleaned up.
#' @param files a logical. Should workshop files be removed?
#' @param cache a logical. Should workshop cache be cleared?
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @export


clean_workshops <- function(path = ".", files = TRUE, cache = TRUE, verbose = TRUE) {

  if (!files & !cache) {
    warning("Nothing to do!")
    invisible(NULL)
  } else {
    if (files) {
      dr <- find_d(path, "workshop[0-9]{2}-(fr|en)_files$")
      if (length(dr)) unlink(dr, recursive = TRUE)
    }
    if (cache) {
      dr <- find_d(path, "workshop[0-9]{2}-(fr|en)_cache$")
      if (length(dr)) unlink(dr, recursive = TRUE)
    }
    invisible(NULL)
  }

}

find_d <- function(path = ".", pattern) {
  ld <- list.dirs(path = path, recursive = TRUE, full.names = TRUE)
  ld[grepl(pattern, ld)]
}

#' Update template
#'
#' Download the template, check whether the files must be updated and do the
#' update of required.
#'
#' @param path path to the workshops where to find the template to be updated.
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @importFrom rmarkdown render
#'
#' @export

update_template <- function(path = ".", verbose = TRUE) {
  wkshps <- find_d(path, "workshop[0-9]{2}-(fr|en)$")
  if (!length(wkshps)) stop("No workshop files found!")
  download_template(verbose = verbose)
  nm <- "templateWorkshops-master"
  t_files <- list.files(nm, pattern = "^qcbsR.*[ls]$", full.names = TRUE)
  for (fil_i in t_files) {
    for (fol_j in wkshps) {
      fl2 <- paste0(fol_j, "/", gsub(".*/", "", fil_i))
      compare_copy_files(fil_i, fl2, verbose = verbose)
    }
  }
  ##
  unlink(nm, recursive = TRUE)
  invisible(NULL)
}


#' Read list of dependencies and install packages
#'
#' @param file path to the list of dependencies
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @importFrom yaml read_yaml
#' @importFrom utils download.file install.packages installed.packages
#' @importFrom remotes install_github
#' @export

install_workshops_pkgs <- function(file = "pkgs.yaml", verbose = TRUE) {
  lapply(file, install_workshop_pkgs_indiv, verbose = verbose)
}

install_workshop_pkgs_indiv <- function(file = "pkgs.yaml", verbose = TRUE) {
  ls_file <- read_yaml(file)

  nbpkgs <- Reduce("+", lapply(ls_file, length))
  if (nbpkgs) {
    if (verbose)
      message("Found ", nbpkgs, " to be installed if not already!")
    if (length(ls_file$cran_pkgs)) {
      install_cran_pkgs(ls_file$cran_pkgs)
    }
    if (length(ls_file$archive_pkgs)) {
      install_cran_archived_pkgs(ls_file$archive_pkgs)
    }
    if (length(ls_file$repos_pkgs)) {
      install_repos_pkgs(ls_file$repos_pkgs)
    }
    if (length(ls_file$github_pkgs)) {
        for (i in seq_len(length(ls_file$github_pkgs))) {
         install_github(ls_file$github_pkgs[[i]])
        }
    }
  } else if (verbose) message("No packages to be installed")

  invisible(ls_file)
}


install_cran_pkgs <- function(x) {
  for (i in seq_along(x)) {
    if (!x[i] %in% rownames(installed.packages()))
      install.packages(x[i], repos = "https://cran.wu.ac.at/")
  }
  invisible(NULL)
}

install_cran_archived_pkgs <- function(x) {
  for (i in seq_along(x)) {
    if (!x[i]$pkgname %in% rownames(installed.packages())) {
      f <- tempfile()
      download.file(x[[i]]$url, destfile = f)
      install.packages(pkgs = f, type="source", repos = NULL)
    }
  }
  invisible(NULL)
}

install_repos_pkgs <- function(x) {
  for (i in seq_along(x)) {
    if (!x[i]$pkgname %in% rownames(installed.packages())) {
       install.packages(x[[i]]$pkgname, repos = x[[i]]$repos, type="source")
    }
  }
  invisible(NULL)
}

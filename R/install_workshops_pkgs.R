#' Read list of dependencies and install packages
#'
#' @param file path to the list of dependencies
#' @param verbose a logical. Should extra information be reported on progress?
#' @param x a character string of the name of a package.
#' @param path path where the workshops files
#' @param ... further arguments passed to [remotes::install_deps()].
#'
#' @export

install_workshops_pkgs <- function(file = "pkgs.yaml", verbose = TRUE) {
  if (!length(file)) {
    warning("No list of packages found!")
  } else {
    lapply(file, function(x) install_workshop_pkgs_indiv(x, verbose = verbose))
  }
  invisible(NULL)
}


#' @rdname install_workshops_pkgs
#' @export
install_workshops_pkgs_remotes <- function(path, ...) {
  des <- find_f(path, "^DESCRIPTION")
  lapply(gsub("/[^/]*$", "", des), function(x) install_deps(x, ...))
  invisible(NULL)
}


#' @rdname install_workshops_pkgs
#' @export

install_workshop_pkgs_indiv <- function(file = "pkgs.yaml", verbose = TRUE) {
  ls_file <- read_yaml(file)

  nbpkgs <- Reduce("+", lapply(ls_file, length))
  if (nbpkgs) {
    if (verbose) message(crayon::blue(nbpkgs, "packages required."))
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
    success_msg("Packages successfully installed")
  } else if (verbose) success_msg("Packages required are already installed")

  invisible(ls_file)
}

#' @rdname install_workshops_pkgs
#' @export
install_cran_pkgs <- function(x) {
  for (i in seq_along(x)) {
    if (!requireNamespace(x[i], quietly = TRUE))
      install.packages(x[i], repos = "https://cran.wu.ac.at/")
  }
  invisible(NULL)
}

#' @rdname install_workshops_pkgs
#' @export
install_cran_archived_pkgs <- function(x) {
  for (i in seq_along(x)) {
    if (!requireNamespace(x[[i]]$pkgname, quietly = TRUE)) {
      f <- tempfile()
      download.file(x[[i]]$url, destfile = f)
      install.packages(pkgs = f, type="source", repos = NULL)
    }
  }
  invisible(NULL)
}

#' @rdname install_workshops_pkgs
#' @export
install_repos_pkgs <- function(x) {
  for (i in seq_along(x)) {
    if (!requireNamespace(x[[i]]$pkgname, quietly = TRUE)) {
       install.packages(x[[i]]$pkgname, repos = x[[i]]$repos, type="source")
    }
  }
  invisible(NULL)
}

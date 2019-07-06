#' Read list of dependencies and install packages
#'
#' @param file path to the list of dependencies
#' @param verbose a logical. Should extra information be reported on progress?
#'
#' @importFrom yaml read_yaml
#' @importFrom utils download.file install.packages installed.packages
#' @importFrom remotes install_github
#' @export

install_pkgs <- function(file = "pkgs.yaml", verbose = TRUE) {
  ls_file <- read_yaml(file)

  nbpkgs <- Reduce("+", lapply(ls_file, length))
  if (nbpkgs) {
    if (verbose) message("Found ", nbpkgs, " to be installed")
    if (length(ls_file$cran_pkgs)) {
      for (i in seq_len(length(ls_file$cran_pkgs))) {
        if (! ls_file$cran_pkgs[i] %in% rownames(installed.packages()))
          install.packages(ls_file$cran_pkgs[i], repos = "https://cran.wu.ac.at/")
      }
    }
    if (length(ls_file$archive_pkgs)) {
      for (i in seq_len(length(ls_file$archive_pkgs))) {
        f <- tempfile()
        download.file(ls_file$archive_pkgs[[i]]$url, destfile = f)
        install.packages(pkgs = f, type="source", repos = NULL)
      }
    }
    if (length(ls_file$repos_pkgs)) {
      for (i in seq_len(length(ls_file$repos_pkgs))) {
        tmp <- ls_file$repos_pkgs[[i]]
       install.packages(tmp$pkgname, repos = tmp$repos, type="source")
      }
    }
    if (length(ls_file$github_pkgs)) {
        for (i in seq_len(length(ls_file$github_pkgs))) {
         install_github(ls_file$github_pkgs[[i]])
        }
    }
  } else if (verbose) message("No packages to be installed")

  invisible(ls_file)
}


# rea

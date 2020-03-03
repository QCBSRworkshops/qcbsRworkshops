#' Return bagdes for a given workshop.
#'
#' @param workshop_id workshop identifier, see [workshops_df()].
#' @param lang the language for the badges.

get_badges <- function(workshop_id , lang=c("en", "fr")) {

  lang <- match.arg(lang)
  id2 <- sprintf("%02d", workshop_id)

  if (lang == "en") {
    prs <- "Presentation"
    atl <- "Workshop"
  } else {
    prs <- "Pr\u00e9sentation"
    atl <- "Atelier"
  }

  tra <- paste0("[![Build Status](https://img.shields.io/travis/QCBSRworkshops/workshop",
  id2,
  "/dev?style=for-the-badge)](https://travis-ci.org/QCBSRworkshops/workshop", id2, ")")

  pres <- paste0(
    "[![](https://img.shields.io/static/v1?style=for-the-badge&label=",
    prs, "&message=", atl,
    "%20", workshop_id,
    "&color=blue)](https://qcbsrworkshops.github.io/workshop",
    id2, "/workshop", id2, "-", lang, "/workshop", id2, "-", lang, ".html)")

  wiki <- paste0("[![](https://img.shields.io/static/v1?style=for-the-badge&label=Wiki&message=",
    atl, "%20", workshop_id, "&color=violet)](https://wiki.qcbs.ca/r_",
    tolower(atl), workshop_id , ")")

  cat(tra, pres, wiki, sep="\n")

  invisible(paste(tra, pres, wiki, sep="\n"))
}

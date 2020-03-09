#' Return badges for a given workshop.
#'
#' @param workshop_id workshop identifier, see [workshops_df()].
#' @param lang the language for the badges (either "en" or "fr").
#' @param style badges style.
#' @param clip a logical. Should the badges be copied to the clipboard.
#' @export
#' @examples
#' get_badges(1, clip = FALSE)
#' get_badges(4, lang = "fr", clip = FALSE)

get_badges <- function(workshop_id, lang = c("en", "fr"),
  style = c("flat-square", "plastic", "flat", "for-the-badge", "social"),
  clip = TRUE) {

  lang <- match.arg(lang)
  style <- match.arg(style)
  id2 <- sprintf("%02d", workshop_id)

  if (lang == "en") {
    prs <- "Slides"
    atl <- "Workshop"
  } else {
    prs <- "Diapos"
    atl <- "Atelier"
  }

  wiq <- glue("https://wiki.qcbs.ca/r_{tolower(atl)}{workshop_id}")

  wid <- glue("workshop{workshop_id}")
  wid2 <- sprintf("workshop%02d", workshop_id)
  basurl <- glue("https://qcbsrworkshops.github.io/{wid2}/{wid2}-{lang}")

  tra <- get_badge_travis("QCBSRworkshops", wid2, "dev", style = style)
  gh <- get_badge_gh("QCBSRworkshops", wid2, "dev", color = "6f42c1",
    style = style)
  html <- get_badge_one(url = glue("{basurl}/{wid2}-{lang}.html"),
    logo = "html5", label = prs, message = id2, color="red", style = style)
  pdf <- get_badge_one(url = glue("{basurl}/{wid2}-{lang}.pdf"),
    logo = "adobe-acrobat-reader", label = prs, message = id2, color="red",
    style = style)
  wiki <- get_badge_one(url = wiq, logo="wikipedia", label = "wiki",
    message = id2, style = style)
  scr <- get_badge_one(url = glue("{basurl}/{wid2}-{lang}.R"),
  logo = "r", label = "script", message = id2, color = "2a50b8", style = style)

  out <- paste(tra, gh, wiki, html, pdf, scr, sep="\n")
  cat(out, "\n")
  if (clip) write_clip(out)

  info_msg("badges copied in your clipboard!")
  invisible(out)
}


get_badge_one <- function(url = NULL, main = url_shield.io(),
  style = "flat-square", label=NULL, message=NULL, color = NULL, logo = NULL, logoColor = NULL,
  alt = "badge") {

  out <- glue("{main}style={style}")
  if (!is.null(label)) out <- glue("{out}&label={label}")
  if (!is.null(message)) out <- glue("{out}&message={message}")
  if (!is.null(color)) out <- glue("{out}&color={color}")
  if (!is.null(logo)) out <- glue("{out}&logo={logo}")
  if (!is.null(logoColor)) out <- glue("{out}&logoColor={logoColor}")
  out <- glue("![{alt}]({out})")

  if (!is.null(url)) {
    sprintf("[%s](%s)", out, url)
  } else out
}

get_badge_travis <- function(user, repo, branch, ...) {
  main <- glue("https://img.shields.io/travis/{user}/{repo}/{branch}?")
  url <- glue("https://travis-ci.org/{user}/{repo}")
  get_badge_one(url, main, logo="travis", alt = "Build Status", ...)
}

get_badge_gh <- function(user, repo, branch, ...) {
  url <- glue("https://github.com/{user}/{repo}")
  get_badge_one(url, logo="github", label = "repo", message = branch,
  ...)
}

url_shield.io <- function() "https://img.shields.io/static/v1?"
# c("plastic", "flat", "flat-square", "for-the-badge", "social")

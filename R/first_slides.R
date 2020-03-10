#' Returns the two first slides of a workshops
#'
#' Returns the two first slides of a workshop (title slide not included).
#'
#' @param workshop_id workshop identifier, see [workshops_df()].
#' @param pkgs vector of packages required for the workshops, see [list_packages()].
#' @param lang the language for the badges (either "en" or "fr").
#' @param clip a logical. Should the badges be copied to the clipboard?
#'
#' @export
#' @examples
#' first_slides(2, c("dplyr", "tidyr"))

first_slides <- function(workshop_id, pkgs, lang = c("en", "fr"), clip = FALSE)
{
  #
  lang <- match.arg(lang)
  # badges but not the Travis one
  bdg <- paste(
    get_badges(workshop_id, clip = FALSE, show = FALSE, lang = lang,
      style = "for-the-badge")[-1L],
    collapse = "\n"
  )
  lsp <- list_packages(pkgs, clip = FALSE, show = FALSE)
  #
  if (lang == "en") {
    tx1 <- "# About this workshop"
    tx2 <- "# Required packages"
  } else {
    tx1 <- "# \u00c0 propos de cet atelier"
    tx2 <- "# Packages requis"
  }
  out <- glue("{tx1}\n{bdg}\n\n---\n\n{tx2}\n\n{lsp}")
  if (clip) {
    write_clip(out)
    info_msg("first slides copied to the clipboard!")
  }
  invisible(out)
}


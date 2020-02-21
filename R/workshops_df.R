#' Table of workshops
#'
#' Return a data frame with workshop names in both French and English.
#'
#' @export
#'
#' @examples
#' workshops_df()

workshops_df <- function() {
  data.frame(
    id = 1:10,
    name_fr = c(
      "Introduction \u00e0 R",
      "Charger et manipuler les donn\u00e9es",
      "Introduction \u00e0 ggplot2",
      "Mod\u00e8les lin\u00e9aires ",
      "Programmation en R",
      "Mod\u00e8les lin\u00e9aires mixtes",
      "Mod\u00e8les lin\u00e9aires mixtes g\u00e9n\u00e9ralis\u00e9s",
      "Mod\u00e8les additifs g\u00e9n\u00e9ralis\u00e9s",
      "Analyses multivari\u00e9es",
      "Analyses multivari\u00e9es avanc\u00e9es "
    ),
    name_en = c(
      "Introduction to R",
      "Loading and manipulating data",
      "Introduction to ggplot2",
      "Linear models",
      "Programming in R",
      "Linear mixed models",
      "Generalized linear mixed models",
      "Generalized additive models",
      "Multivariate analyses",
      "Advanced multivariate analyses"
    )
  )
}
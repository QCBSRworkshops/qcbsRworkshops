#' Generate presenter email
#'
#' Generate presenter email to be sent two weeks beforehand.
#'
#' @param workshop_id workshop identifier, see [workshops_df()].
#' @param pres_name a character string with the presenter name.
#' @param details_en a character string indicating where and when the workshop will be held in English.
#' @param details_fr same as `details_en` but in French.
#' @param lang the langage of the mail, by default mail will contain
#' a French and an English version.
#' @param markdownify a logical. Should [balstula::md()]() be used. Default
#' is set to `TRUE`.
#'
#' @details
#' Currently, the email is generated with [blastula::compose_email()] and
#' you need to copy paste it.
#'
#' @export
#'
#' @examples
#' mail_en <- mail_workshop(7, "Kevin Cazelles", lang = "en",
#'   details_en = "\u00e0 l'UdeM, salle A-2553,  campus MIL, le vendredi 28 F\u00e9vrier
#'   2010 de 13h \u00e0 17h")

mail_workshop <- function(workshop_id, pres_name, lang = c("both", "en", "fr"),
  details_en = "", details_fr = "", markdownify = TRUE) {

  wkh <- workshops_df()[workshop_id[1L],]
  lang <- match.arg(lang)

  if (details_fr == "" && (lang == "fr" | lang == "both"))
    stop("SVP, indiquez la date et le lieu de l'atelier.")
  if (details_en == "" && (lang == "en" | lang == "both"))
    stop("Please indicate where and when the workshop will be held.")

  msg_fr <- paste0("Bonjour!\n
Vous \u00eates inscrit \u00e0 l\u2019atelier R #", wkh$id, " \"**", wkh$name_fr, "**\" du
Centre de la science de la biodiversit\u00e9 du Qu\u00e9bec (CSBQ) qui sera donn\u00e9 <b>",
details_fr,"</b>. En pr\u00e9vision de cet atelier, veuillez prendre note des points
suivants :\n
1. SVP, venir avec votre ordinateur portable et avec les logiciels R et RStudio
install\u00e9s. Vous pouvez aussi t\u00e9l\u00e9charger le script et les jeux de donn\u00e9es pour
l\u2019atelier \u00e0 l\u2019adresse suivante : <https://wiki.qcbs.ca/r_atelier", wkh$id, ">.
Nous vous recommandons aussi d\u2019ex\u00e9cuter le script dans son enti\u00e8ret\u00e9 au moins
une fois avant l\u2019atelier pour v\u00e9rifier que tout fonctionne sur votre ordinateur
portable et pour t\u00e9l\u00e9charger/installer toutes les librairies utilis\u00e9es pendant
l\u2019atelier.\n
2. Si vous ne pouvez plus venir \u00e0 l\u2019atelier, avisez-nous par courriel au minimum
5 jours avant l\u2019atelier pour \u00e9viter de payer une p\u00e9nalit\u00e9 de 100$.\n
3. Si vous n\u2019\u00eates pas membre du CSBQ, n\u2019oubliez pas d'apporter votre re\u00e7u
imprim\u00e9 \u00e0 l\u2019atelier.\n
4. L'acc\u00e8s \u00e0 l\u2019internet ne devrait pas \u00eatre n\u00e9cessaire pour suivre cet atelier
dans la mesure o\u00f9 vous avez ex\u00e9cut\u00e9 le script et que toutes les biblioth\u00e8ques R
requises sont d\u00e9j\u00e0 install\u00e9es. Si vous suivez un atelier \u00e0 une autre institution
que la v\u00f4tre et que vous voulez avoir acc\u00e8s \u00e0 internet, vous pouvez utiliser le
r\u00e9seau \u00ab\u2009eduroam\u2009\u00bb (pour plus d\u2019infos, consultez ce lien :
<http://qcbs.ca/wiki/eduroam_fr>). Si vous n\u2019\u00eates pas \u00e9tudiant universitaire et/ou
n\u2019avez pas l'acc\u00e8s au r\u00e9seau eduroam, nous ne serons pas capables de vous donner
un code d\u2019acc\u00e8s pour internet le jour de l\u2019atelier.\n
5. Si vous avez de questions sur les installations ou sur cet atelier, veuillez
parler \u00e0 vos directement \u00e0 un des vos pr\u00e9sentateurs. \n\n Merci et au plaisir de vous voir \u00e0 l'atelier!\n\n", pres_name)


msg_en <- paste0("Hello!\n
You are registered for the QCBS R Workshop #", wkh$id, " \"**", wkh$name_en, "**\" that will be held <b>", details_en,"</b>. In preparation for the workshop
please note the following:\n
1. Please come with your laptop and the relevant programs (R and RStudio) installed. You can also download the script we will be using in this workshop at the following website: <https://wiki.qcbs.ca/r_workshop", wkh$id, ">. We recommend that you execute the entire script at least once before coming to the workshop to make sure that everything works on your laptop and to download and install all the libraries we will be using during the workshop.\n
2. If you can no longer make it to the workshop, please advise us 5 days in advance by email, otherwise, you will receive a 100$ penalty which will be billed to your supervisor.\n
3. If you are not a member of the QCBS please bring receipt of payment to the workshop.\n
4. Internet access should not be necessary to follow the workshop if you executed the script before coming to make sure you had downloaded all the necessary R libraries. If you are taking the workshop at a different institution than your own and would like to have access to the internet during the workshop, please ensure that you can connect to the eduroam network (more info here: <http://qcbs.ca/wiki/eduroam>). If you do not have access to eduroam or to the university\u2019s network, we may not be able to provide you with  temporary access to the internet.\n
5. If you have any questions concerning this workshop or its venue, please reach one of the presenters so you can be helped to the best of our ability!.\n
Thanks! Looking forward to see you at the workshop!\n\n", pres_name, "\n")

  tit_fr <- paste0("[S\u00e9rie d\u2019ateliers R du CSBQ] Atelier #", wkh$id," \u2013 ",
    wkh$name_fr)
  tit_en <- paste0("[QCBS R Workshop Series] Workshop #", wkh$id," \u2013 ",
    wkh$name_en)

  if (lang %in% c("fr", "both")) {
    bod <- msg_fr
    tit <- tit_fr
  } else {
    bod <- msg_en
    tit <- tit_en
  }

  if (lang == "both") {
    bod <- paste0("*English version follows the French one.*\n\n", bod, "\n\n\n <hr>\n\n", msg_en)
    tit <- paste0(tit, " | ", tit_en)
  }

  fot <- "Mail generated using the [blastula package](https://github.com/rich-iannone/blastula)"
  if (markdownify) {
    blastula::compose_email(
      header = tit,
      body = blastula::md(bod),
      footer = blastula::md(fot)
    )
  } else {
    blastula::compose_email(
      header = tit,
      body = bod,
      footer = fot
    )
  }


}
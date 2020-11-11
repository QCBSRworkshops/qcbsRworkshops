# qcbsRworkshops (devel)

* `build_workshop()` gains an argument `lang` to select which version of the workshop (the French one, the English one or both) to be built. 
* use `skip_cleanup` in Travis CI configuration file. 
* add contributing guidelines. 

# qcbsRworkshops 0.5.0

* add `use_travis()` to add Travis CI configuration file.
* `fs` added in dependencies. 
* minor improvements of README. 

# qcbsRworkshops 0.4.0

* review message functions.  
* review CI workflow. 
* `get_badge_one()` gains one argument `html` to obtain badges in HTML.

# qcbsRworkshops 0.3.0

* New function `first_slides()` that generates the two first slides.
* `get_badges()` and `list_packages()` gain an argument `show` to control text
should be output.
* `get_badges()` gains an argument `style` to control badges style.
* Fix URL in `get_badges()` for pdf files an R scripts.
* New function `list_packages()` to create a list of package for the first slides of package.

# qcbsRworkshops 0.2.0

* Use GitHub Actions instead of Travis
* `build_workshop()` gains an argument `script` to export R code.
* Simplify messages displayed when HTML presentations are successfully rendered.
* `install_workshops_pkgs_remotes()` use package `remotes` to install packages required for a given workshop.
* `get_badges()` now returns 5 badges.
* `get_badges()` gains argument `clip` to copy badges to the clipboard.

# qcbsRworkshops 0.1.0

* `build_workshop()` gains an argument `pdf` to export presentation as pdf
files (call to `pagedown::chrome_print()`).
* New function `get_badges()` returns badges for README.
* Properly check the existence of template files.
* Correct list of template files in helper function `template_files()`.
* Better regex for the R Markdown files of the workshop.

# qcbsRworkshops 0.0.5

* `workshop_df()` returns a data frame with the names of the workshops.
* `mail_workshop()` generates presenter emails.

# qcbsRworkshops 0.0.4

* test installed packages with `requireNamespace()`
* add `success_msg()` :sparkles:

# qcbsRworkshops 0.0.3

* add `extract_Rcode_workshops()` :sparkles:
* `update_template()` handles missing files.
* `update_template()` is called when template files are missing.

# qcbsRworkshops 0.0.2

* export `download_workshops()` (previously `download_workshop()`).
* add `update_template()` :sparkles:
* add `clean_workshop()` :sparkles:
* add small :bug: in `install_repos_pkgs()` and in `install_cran_archived_pkgs()` caused by misuses of lists.

# qcbsRworkshops 0.0.1

* Added `build_workshop()` build workshops with option to download files.
* Added `render_workshops()` to render the workshop.
* Added `install_workshop_pkgs()` to install packages dependencies stored
in `pkgs.yml` files.
* Added a `NEWS.md` file to track changes to the package.

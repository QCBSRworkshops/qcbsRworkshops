# qcbsRworkshops 0.0.5.9000

* New function `get_badges()` returns badges for README.
* Properly check the existence of template files.
* Correct list of template files in helper function `template_files()`.
* Better regex for the RMarkdown files of the workshop.

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

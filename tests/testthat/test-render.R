context("Download and build workshop 1")

dir <- "tmpfiles"
if (!dir.exists(dir)) dir.create(dir)
# build_workshops(dir, download = TRUE, id = 1, verbose = FALSE)

lsen <- list.files(paste0(dir, "/workshop01-dev/workshop01-en"))
lsfr <- list.files(paste0(dir, "/workshop01-dev/workshop01-fr"))

test_that("expected behavior", {
  # expect_true("workshop01-dev" %in% list.files(dir))
  expect_error(build_workshops(dir, download = TRUE))
  expect_error(suppressWarnings(
        build_workshops(dir, download = TRUE, id = 0, verbose = FALSE)
      ))
  # expect_true("workshop01-en.html" %in% lsen)
  # expect_true("workshop01-en.Rmd" %in% lsen)
  # expect_true("workshop01-fr.Rmd" %in% lsfr)
  # expect_true("workshop01-fr.html" %in% lsfr)
})

unlink(dir, recursive = TRUE)

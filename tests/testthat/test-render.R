context("Download and build workshop 1")

dir <- "tmpfiles"
if (!dir.exists(dir)) dir.create(dir)
# build_workshops(dir, download = TRUE, id = 1, verbose = FALSE)

lsf <- list.files(dir, recursive = TRUE)

test_that("expected behavior", {
  expect_error(build_workshops(dir, download = TRUE))
  expect_error(suppressWarnings(
        build_workshops(dir, download = TRUE, id = 0, verbose = FALSE)
      ))
  # expect_true(any(grepl("workshop01-en\\.html$", lsf)))
  # expect_true(any(grepl("workshop01-en\\.Rmd$", lsf)))
  # expect_true(any(grepl("workshop01-fr\\.Rmd$", lsf)))
  # expect_true(any(grepl("workshop01-fr\\.html$", lsf)))
})

unlink(dir, recursive = TRUE)

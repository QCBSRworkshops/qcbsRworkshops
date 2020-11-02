context("Download and build workshop 1")

dir <- "tmpfiles"
if (!dir.exists(dir)) dir.create(dir)

## Cannot test this below with `check()`
# build_workshops(dir, download = TRUE, id = 1, verbose = FALSE)
# download_workshops(1)
# update_template()
# extract_Rcode_workshops()

lsf <- list.files(dir, recursive = TRUE)

test_that("expected behavior", {
  expect_error(build_workshops(dir, download = TRUE))
  expect_error(update_template(verbose = FALSE))
  expect_error(suppressWarnings(
        build_workshops(dir, download = TRUE, id = 0, verbose = FALSE)
      ))
})

# build_workshops(id =  6, download = T, pdf = TRUE)  

# unlink(dir, recursive = TRUE)

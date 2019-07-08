context("Remove workshop files and cache")


dd <- "tmpfiles"
tst1 <- "worshop02-en_files"
tst2 <- "workshop02-en_files"
tst3 <- "workshop02-en_cache"

if (!dir.exists("tmpfiles")) dir.create("tmpfiles")
dir.create(paste0(dd, "/", tst1))
dir.create(paste0(dd, "/", tst2))
dir.create(paste0(dd, "/", tst3))


test_that("warning and clear files", {
  expect_warning(clean_workshops(dd, FALSE, FALSE))
  clean_workshops(cache = FALSE)
  expect_true(tst3 %in% list.files(dd))
  expect_true(!tst2 %in% list.files(dd))
  clean_workshops()
  expect_true(!tst3 %in% list.files(dd))
  expect_true(tst1 %in% list.files(dd))
})

unlink(dd, recursive = TRUE)

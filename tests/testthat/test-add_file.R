context("Add files") 

use_travis()
test_that("use_travis() works", {
  expect_true(file.exists(".travis.yml"))
  res <- use_travis()
  expect_true(!res)
  res <- use_travis(force = TRUE)
  expect_true(res)
})

file.remove(".travis.yml")
library(testthat)
library(git2r)
library(reprex)
library(covr)

# Mock function for readRDS
mock_readRDS <- function(file) {
  list(pin1 = "1.0.0", pin2 = "2.0.0")
}

# Test suite
test_that("get_pin_versions_by_hash works correctly", {
  
  # Mock repository
  mock_repo <- structure(list(), class = "git_repository")
  
  # Mock functions
  with_mock(
    `git2r::repository` = function(...) mock_repo,
    `git2r::checkout` = function(...) NULL,
    `git2r::revparse_single` = function(...) list(sha = function() "abcdef1234567890"),
    `git2r::sha` = function(...) "abcdef1234567890",
    readRDS = mock_readRDS,
    {
      # Test with specific commit hash
      result1 <- get_pin_versions_by_hash("/path/to/repo", "specific_hash")
      expect_type(result1, "list")
      expect_named(result1, c("pin1", "pin2"))
      expect_equal(result1$pin1, "1.0.0")
      expect_equal(result1$pin2, "2.0.0")
      
      # Test without commit hash (latest commit)
      result2 <- get_pin_versions_by_hash("/path/to/repo")
      expect_type(result2, "list")
      expect_named(result2, c("pin1", "pin2"))
      expect_equal(result2$pin1, "1.0.0")
      expect_equal(result2$pin2, "2.0.0")
    }
    )
  })

# Test error handling
test_that("get_pin_versions_by_hash handles errors", {
  expect_error(
    get_pin_versions_by_hash("/non/existent/path")
  )
})

#test_file code / run in terminal
#test_file("C:/Users/jefferson.et/Documents/Rstudio/Version Control
#/tests/testthat/test-get_pin_versions_by_hash.R")


#file coverage
#covr <- file_coverage("C:/Users/jefferson.et/Documents/Rstudio/Version Control/get_pin_versions_by_hash.R",
#                      "C:/Users/jefferson.et/Documents/Rstudio/Version Control/tests/testthat/test-get_pin_versions_by_hash.R")
#covr
#
#report(covr)


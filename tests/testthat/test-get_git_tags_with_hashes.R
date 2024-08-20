library(testthat)
library(git2r)
library(reprex)

# Mock function for get_pin_versions_by_hash
mock_get_pin_versions_by_hash <- function(repo_path, commit_hash) {
  list(pin1 = "1.0.0", pin2 = "2.0.0")
}

# Test suite
test_that("get_git_tags_with_hashes works correctly", {
  
  # Mock repository with known tags
  mock_repo <- structure(list(), class = "git_repository")
  mock_tags <- list(
    structure(list(name = "tag1", sha = "abc123"), class = "git_tag"),
    structure(list(name = "tag2", sha = "def456"), class = "git_tag")
  )
  
  # Mock functions
  with_mock(
    `git2r::repository` = function(...) mock_repo,
    `git2r::tags` = function(...) mock_tags,
    `get_pin_versions_by_hash` = mock_get_pin_versions_by_hash,
    dir.exists = function(...) TRUE,
    {
      result <- get_git_tags_with_hashes("/path/to/repo")
      
      # Check that the result is a list
      expect_type(result, "list")
      
      # Check the number of tags
      expect_equal(length(result), 2)
      
      # Check the structure of each tag entry
      expect_equal(length(result[[1]]), 3)
      expect_equal(result[[1]]$tag, "tag1")
      expect_equal(result[[1]]$hash, "abc123")
      expect_equal(result[[1]]$pin_versions, list(pin1 = "1.0.0", pin2 = "2.0.0"))
      
      expect_equal(length(result[[2]]), 3)
      expect_equal(result[[2]]$tag, "tag2")
      expect_equal(result[[2]]$hash, "def456")
      expect_equal(result[[2]]$pin_versions, list(pin1 = "1.0.0", pin2 = "2.0.0"))
    }
  )
})

# Test error handling
test_that("get_git_tags_with_hashes handles errors", {
  # Test non-existent path
  with_mock(
    dir.exists = function(...) FALSE,
    {
      expect_error(
        get_git_tags_with_hashes("/non/existent/path"),
        "The system cannot find the path specified"
      )
    }
  )
})

#test_file code / run in terminal
#test_file("C:/Users/jefferson.et/Documents/Rstudio/Version Control
#/tests/testthat/test-get_git_tags_with_hashes.R")


#file coverage
#covr <- file_coverage("C:/Users/jefferson.et/Documents/Rstudio/Version Control/get_pin_versions_by_hash.R",
#                      "C:/Users/jefferson.et/Documents/Rstudio/Version Control/tests/testthat/test-get_pin_versions_by_hash.R")
#covr
#
#report(covr)
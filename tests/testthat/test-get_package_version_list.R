library(testthat)
library(git2r)
library(reprex)

# Test suite
test_that("get_package_version_list works correctly", {
  
  # Mock repository with known commits
  mock_repo <- structure(list(), class = "git_repository")
  mock_commits <- list(
    structure(list(sha = "abc123"), class = "git_commit"),
    structure(list(sha = "def456"), class = "git_commit"),
    structure(list(sha = "ghi789"), class = "git_commit")
  )
  
  # Mock functions
  with_mock(
    `git2r::repository` = function(...) mock_repo,
    `git2r::commits` = function(...) mock_commits,
    dir.exists = function(...) TRUE,  # Mock dir.exists to always return TRUE
    {
      result <- get_package_version_list("/path/to/repo")
      
      # Debugging output to inspect the result
      print("Result from get_package_version_list:")
      print(result)
      
      # Check that the result is a character vector
      expect_type(result, "character")
      
      # Check that the vector has the correct number of elements
      expect_equal(length(result), 3)
      
      # Check that the commit hashes are correct
      expect_equal(result, c("abc123", "def456", "ghi789"))
    }
  )
})

# Test empty repository (no commits)
test_that("get_package_version_list handles an empty repository", {
  
  # Mock repository with no commits
  mock_repo <- structure(list(), class = "git_repository")
  mock_commits <- list()
  
  # Mock functions
  with_mock(
    `git2r::repository` = function(...) mock_repo,
    `git2r::commits` = function(...) mock_commits,
    dir.exists = function(...) TRUE,  # Mock dir.exists to always return TRUE
    {
      result <- get_package_version_list("/path/to/repo")
      
      # Check that the result is a character vector
      expect_type(result, "list")
      
      # Check that the vector is empty
      expect_equal(length(result), 0)
    }
  )
})

# Test error handling
test_that("get_pin_versions_by_hash handles errors", {
  # Test non-existent path
  with_mock(
    dir.exists = function(...) FALSE,
    {
      expect_error(
        get_package_version_list("/non/existent/path"),
        "The system cannot find the path specified"
      )
    }
  )
})



#test_file code / run in terminal
#test_file("C:/Users/jefferson.et/Documents/Rstudio/Version Control
#/tests/testthat/test-get_package_version_list.R")


#file coverage
#covr <- file_coverage("C:/Users/jefferson.et/Documents/Rstudio/Version Control/get_pin_versions_by_hash.R",
#                      "C:/Users/jefferson.et/Documents/Rstudio/Version Control/tests/testthat/test-get_pin_versions_by_hash.R")
#covr
#
#report(covr)
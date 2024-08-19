<<<<<<< HEAD
library(git2r)
library(reprex)

get_package_version_list <- function(repo_path) {
  
  if (!dir.exists(repo_path)) {
    stop("The system cannot find the path specified")
  }
  
  repo <- repository("path/to/your/repo")
  commit_list <- commits(repo)
  
  commit_hashes <- sapply(commit_list, function(commit) commit$sha)
  
  #return data.frame
  return(commit_hashes)
=======
library(git2r)
library(reprex)

get_package_version_list <- function(repo_path) {
  
  if (!dir.exists(repo_path)) {
    stop("The system cannot find the path specified")
  }
  
  repo <- repository("path/to/your/repo")
  commit_list <- commits(repo)
  
  commit_hashes <- sapply(commit_list, function(commit) commit$sha)
  
  #return data.frame
  return(commit_hashes)
>>>>>>> 2faf5b3e380c8bc3aa70444d27e96dad7849d24c
}
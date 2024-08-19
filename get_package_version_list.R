library(git2r)
library(reprex)

get_package_version_list <- function(repo_path) {
  
  #check to see if repo path exists
  if (!dir.exists(repo_path)) {
    stop("The system cannot find the path specified")
  }
  
  #checks the repo
  repo <- repository(repo_path)
  commit_list <- commits(repo)
  
  commit_hashes <- sapply(commit_list, function(commit) commit$sha)
  
  #return list of comit hashes
  return(commit_hashes)
}
library(git2r)
library(reprex)

get_package_version_list <- function(repo_path) {

  #checks to see if the repo_path exists
  if (!dir.exists(repo_path)) {
    stop("The system cannot find the path specified")
  }
  
  #opens the repository and gets every commit
  repo <- repository(repo_path)
  commit_list <- commits(repo)
  
  #takes all the hashes from the commit_list
  commit_hashes <- sapply(commit_list, function(commit) commit$sha)
  
  
  #return data.frame
  return(commit_hashes)
  
  
}


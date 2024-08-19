library(git2r)
library(reprex)


# Function to get pin versions by commit hash
get_pin_versions_by_hash <- function(repo_path, commit_hash = NULL) {
  #check if repo_path exists
  if (!dir.exists(repo_path)) {
    stop("The system cannot find the path specified")
  }
  
  if (!is.null(commit_hash)) {
      
      # Check out the specific commit
      repo <- repository(repo_path)
      checkout(repo, branch = commit-hash)
      
      # Extract pin versions from the file at that commit
      pins_versions <- readRDS("data/published_pins.rda")
      
  }
   else{
      
      #Get most recent commit hash
      latest_hash = revparse_single(repo_path, "HEAD")
      
      #Check out most recent commit hash
      repo <- repository(repo_path) 
      checkout(repo, branch = sha(latest_hash)) 
      
      #Extract latest pin versions from the file
      pins_versions <- readRDS("data/published_pins.rda")
      
  }
  
  #Return the list of pins and pin_versions
  return(pins_versions)
  
  
}









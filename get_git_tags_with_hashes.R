get_git_tags_with_hashes <- function(repo_path = ".") {
  
  # Checks to see if the repo_path exists
  if (!dir.exists(repo_path)) {
    stop("The system cannot find the path specified")
  }
  
  # Open the Git repository
  repo <- repository(repo_path)
  
  # Get all the tags
  tags <- tags(repo)
  
  # Get the hash for each tag
  tags_with_hashes <- lapply(tags, function(tag) {
    tag_name <- tag$name
    tag_hash <- tag$sha
    list(tag = tag_name, hash = tag_hash)
  })
  
  # Get the pin versions for each hash
  tags_with_pin_versions <- lapply(tags_with_hashes, function(tag_hash) {
    tag <- tag_hash$tag
    hash <- tag_hash$hash
    pin_versions <- get_pin_versions_by_hash(repo_path, hash)
    list(tag = tag, hash = hash, pin_versions = pin_versions)
  })
  
  # Return the list of tags and hashes with pin versions
  return(tags_with_pin_versions)
}


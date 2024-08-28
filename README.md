# Functions for Haemdata

<!-- badges: start -->

[![codecov](https://codecov.io/gh/ethanjefferson17/haemdata-function/branch/main/graph/badge.svg)](https://codecov.io/gh/ethanjefferson17/haemdata-function)

  <!-- badges: end -->

## Description

The functions created are used in Haemdata to allow the user to access and use old versions of the Hemdata package and old pin versions of the data collected through Haemdata

## Usage

### get_pin_versions_by_hash

-   The get_pin_versions_by_hash function allows for the user to get a list of all the pins and their versions when the repo_path and the git hash are provided

-   To be able to run this function you must have the git2r package installed

-   The paramaters require the repo path to the github repository and if the git hash is not provided the function will default to the most recent git hash

### get_git_tags_with_hashes

-   The get_git_tags_with_hashes function allows for the user to receive a list of all the tags, or package versions, in a list with their respective git hash and pin versions

-   To be able to run this function you must have the git2r package installed and the get_pin_versions_by_hash function in your environment

-   The parameters require the repo path to the github repository

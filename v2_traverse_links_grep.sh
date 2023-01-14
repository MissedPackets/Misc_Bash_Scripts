#!/bin/bash

#3 variables to edit: url= "", rg -n -H ... "keyword", depth=""

# Define the starting URL
url="http://www.anything.com"

# Create an array to store visited URLs
visited=()
# Create an array to store visited Directories
visited_directories=()

# Define a function to search a URL
search_url() {
  # Check if the URL has already been visited
  if [[ " ${visited[@]} " =~ " ${1} " ]]; then
    return
  fi
  # Add the URL to the visited array
  visited+=("$1")
  # Use curl to download the HTML from the URL and pass it directly to ripgrep
  rg -n -H --line-number -e "keyword" <(curl -Ls $1) -s
  # Print the link being searched
  printf "Searching: $1\n"
  # Use ripgrep to find all links in the HTML
  links=$(curl -Ls $1 | rg -o 'href="[^"]*"' | sed 's/href="//g' | sed 's/"//g')
  # Iterate through the links
  for link in $links; do
    # Check if the link is a full URL or a relative path
    if [[ $link == http* ]]; then
      search_url $link
    elif [[ $link == /* ]]; then
      # check if the link is a directory
      if [ -d "$link" ]; then
        # Check if the directory has already been visited
        if [[ " ${visited_directories[@]} " =~ " ${link} " ]]; then
          continue
        fi
        # Add the directory to the visited_directories array
        # visited

        visited_directories+=("$link")
        search_url $link
      else
        search_url $1/$link
      fi
    else
      search_url $1/$link
    fi
  done
}

# Define a variable for the recursion depth
depth=3

# Define a function to search a URL with recursion depth
search_url_depth() {
  # Check if the recursion depth is 0
  if [[ $1 -eq 0 ]]; then
    return
  fi
  search_url $2
  # Iterate through the links
  for link in $links; do
    # Check if the link is a full URL or a relative path
    if [[ $link == http* ]]; then
      search_url_depth $(($1-1)) $link
    elif [[ $link == /* ]]; then
      # check if the link is a directory
      if [ -d "$link" ]; then
        search_url_depth $(($1-1)) $link
      else
        search_url_depth $(($1-1)) $2/$link
      fi
    else
      search_url_depth $(($1-1)) $2/$link
    fi
  done
}

# Call the search_url_depth function with the starting URL and recursion depth

search_url_depth $depth $url


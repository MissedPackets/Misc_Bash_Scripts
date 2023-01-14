#!/bin/bash

# Define the starting URL
url="http://www.anything.com"

# Create an array to store visited URLs
visited=()

# Define a function to search a URL
search_url() {
  # Check if the URL has already been visited
  if [[ " ${visited[@]} " =~ " ${1} " ]]; then
    return
  fi
  # Add the URL to the visited array
  visited+=("$1")
  # Use curl to download the HTML from the URL and pass it directly to ripgrep
  rg -n -H --line-number -e "Neovim" <(curl -Ls $1) -s
  # Print the link being searched
  printf "Searching: $1\n"
  # Use ripgrep to find all links in the HTML
  links=$(curl -Ls $1 | rg -o 'href="[^"]*"' | sed 's/href="//g' | sed 's/"//g')
  # Iterate through the links
  for link in $links; do
    # Check if the link is a full URL or a relative path
    if [[ $link == http* ]]; then
      search_url $link
    else
      search_url $1/$link
    fi
  done
}

# Call the search_url function with the starting URL
search_url $url


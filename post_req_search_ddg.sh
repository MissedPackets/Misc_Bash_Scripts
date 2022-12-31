#!/bin/bash
# This submits a post request via curl (got the curl cmds from copying the path in the Network's tab, I like how it also copied my U-A)
l="Run any search here.";curl -kLs --compressed 'https://lite.duckduckgo.com/lite/' -X POST -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:108.0) Gecko/20100101 Firefox/108.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate, br' -H 'Referer: https://lite.duckduckgo.com/' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://lite.duckduckgo.com' -H 'Sec-Fetch-User: ?1' --data-raw "q= ${l}"
#Will make a post request for the next page of the output (from the previous search)

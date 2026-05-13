#!/usr/bin/env sh
set -eu

repo_root=$(git rev-parse --show-toplevel)
index_file="$repo_root/site/index.html"
month=$(date "+%B")
day=$(date "+%d")
year=$(date "+%Y")
date_text="$month ${day#0}, $year"

perl -0pi -e "s|<p id=\"last-modified\">Last modified: .*?</p>|<p id=\"last-modified\">Last modified: $date_text</p>|s" "$index_file"

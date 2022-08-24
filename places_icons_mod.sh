!#/bin/bash

#light_icons="$(find Papirus-Colors/*/places/folder* -type f | xargs grep -nl "ColorScheme-Text")"

light_icons="$(find Papirus-Colors/*/places/ -type f -and ! -path '*16x16*' | xargs grep -nl "ColorScheme-Text")"

while IFS= read -r line; do
    echo "$line"
    sed -i 's/\"ColorScheme-Text\"/\"ColorScheme-Background\"/g; s/\"ColorScheme-Text\;fill-opacity:1/\"ColorScheme-Background/g' $line
done <<< "$light_icons"


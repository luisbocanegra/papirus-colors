#!/bin/bash

#light_icons="$(find Papirus-Colors/*/places/folder* -type f | xargs grep -nl "ColorScheme-Text")"

folder_icon_opacity=0.95

echo "Making a clean copy"
cp -rf Papirus-Colors-original/* Papirus-Colors/

light_icons="$(find Papirus-Colors/*/places/ -type f -and ! -path '*16x16*' | xargs grep -nl "ColorScheme-Text")"

match1='\"opacity:*.*\;fill:currentColor\" class=\"ColorScheme-Text\"'
replace1='\"opacity:'${folder_icon_opacity}'\;fill:currentColor\" class=\"ColorScheme-Background\"'

match2='\"opacity:*.*\;fill:currentColor\" class=\"ColorScheme-Text\;fill-opacity:1\"'
replace2='\"opacity:'${folder_icon_opacity}'\;fill:currentColor\" class=\"ColorScheme-Background\"'

echo "Patching icons..."
while IFS= read -r line; do
    sed -i "s/${match1}/${replace1}/g" $line
    sed -i "s/${match2}/${replace2}/g" $line
done <<< "$light_icons"

echo "Copying to ~/.local/share/icons/ ..."
/bin/cp -rf Papirus-Colors/ ~/.local/share/icons/
echo "Done"

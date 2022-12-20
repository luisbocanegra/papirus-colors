#!/bin/bash


light_folder_badge_opacity=0.95
dark_folder_badge_opacity=0.95


echo "Making a clean copy"
cp -rf Papirus-Colors-original/* Papirus-Colors/
cp -rf Papirus-Colors-Dark-original/* Papirus-Colors-Dark/

# list of icons to patch
light_icons="$(find Papirus-Colors/*/places/ -type f -and ! -path '*16x16*' | xargs grep -nl "ColorScheme-Text")"
dark_icons="$(find Papirus-Colors-Dark/*/places/ -type f -and ! -path '*16x16*' | xargs grep -nl "ColorScheme-Background")"

# change badge colors from Text to background and new opacity for light theme
match1='\"opacity:*.*\;fill:currentColor\" class=\"ColorScheme-Text\"'
replace1='\"opacity:'${light_folder_badge_opacity}'\;fill:currentColor\" class=\"ColorScheme-Background\"'

match2='\"opacity:*.*\;fill:currentColor\" class=\"ColorScheme-Text\;fill-opacity:1\"'
replace2='\"opacity:'${light_folder_badge_opacity}'\;fill:currentColor\" class=\"ColorScheme-Background\"'

echo "Patching light icons..."
while IFS= read -r line; do
    sed -i "s/${match1}/${replace1}/g" $line
    sed -i "s/${match2}/${replace2}/g" $line
done <<< "$light_icons"


# change badge opacity for dark theme
match1='\"opacity:*.*\;fill:currentColor\" class=\"ColorScheme-Background\"'
replace1='\"opacity:'${dark_folder_badge_opacity}'\;fill:currentColor\" class=\"ColorScheme-Background\"'

match2='\"opacity:*.*\;fill:currentColor\" class=\"ColorScheme-Text\;fill-opacity:1\"'
replace2='\"opacity:'${dark_folder_badge_opacity}'\;fill:currentColor\" class=\"ColorScheme-Background\"'


echo "Patching dark icons..."
while IFS= read -r line; do
    sed -i "s/${match1}/${replace1}/g" $line
    sed -i "s/${match2}/${replace2}/g" $line
done <<< "$dark_icons"

echo "Copying to ~/.local/share/icons/..."
/bin/cp -rf Papirus-Colors/ ~/.local/share/icons/
/bin/cp -rf Papirus-Colors-Dark/ ~/.local/share/icons/
echo "Done"

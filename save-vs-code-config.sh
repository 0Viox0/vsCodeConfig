#!/bin/bash

userSettingsPath="$HOME/.config/Code/User/settings.json";
userKeybindsPath="$HOME/.config/Code/User/keybindings.json";
snippetsFolderPath="$HOME/.config/Code/User/snippets/";

cp "$userSettingsPath" .
cp "$userKeybindsPath" .
cp -r "$snippetsFolderPath" .

code --list-extensions | tee ./extensions.txt

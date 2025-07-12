#!/bin/bash

DEFAULT_CONFIG_PATHS=(
    "$HOME/.config/Code"
    "$HOME/.config/Code - OSS"
    "$HOME/.config/VSCode"
    "$HOME/.vscode"
)

if [ -z "$1" ]; then
    for path in "${DEFAULT_CONFIG_PATHS[@]}"; do
        if [ -d "$path" ]; then
            CONFIG_PATH="$path"
            break
        fi
    done

    if [ -z "$CONFIG_PATH" ]; then
        echo "❌ Could not auto-detect VSCode config folder."
        echo "ℹ️  Usage: $0 <path_to_vscode_config_folder>"
        echo "   Example: $0 ~/.config/Code\ OSS"
        exit 1
    fi
else
    CONFIG_PATH="$1"
fi

echo "Using VSCode config folder: $CONFIG_PATH"

USER_FOLDER="$CONFIG_PATH/User"
SETTINGS_FILE="$USER_FOLDER/settings.json"
KEYBINDS_FILE="$USER_FOLDER/keybindings.json"
SNIPPETS_FOLDER="$USER_FOLDER/snippets"

BACKUP_DIR="."
mkdir -p "$BACKUP_DIR"

echo "Started backing up..."

if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$BACKUP_DIR/settings.json"
    echo "Copied settings.json"
else
    echo "settings.json not found at $SETTINGS_FILE"
fi

if [ -f "$KEYBINDS_FILE" ]; then
    cp "$KEYBINDS_FILE" "$BACKUP_DIR/keybindings.json"
    echo "Copied keybindings.json"
else
    echo "keybindings.json not found at $KEYBINDS_FILE"
fi

if [ -d "$SNIPPETS_FOLDER" ]; then
    cp -r "$SNIPPETS_FOLDER" "$BACKUP_DIR/snippets"
    echo "Copied snippets folder"
else
    echo "snippets folder not found at $SNIPPETS_FOLDER"
fi

code --list-extensions > "$BACKUP_DIR/extensions.txt"
echo "Saved extensions list to extensions.txt"

echo "Backup completed to $BACKUP_DIR"

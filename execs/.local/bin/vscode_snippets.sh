#!/usr/bin/env bash

TEMP_FILE="$XDG_RUNTIME_DIR/app/snippet_gen/snip_temp.json"
EDIT_FILE="$XDG_RUNTIME_DIR/app/snippet_gen/edit_file.txt"

DISTROBOX_CONFIG_HOME="$XDG_DATA_HOME/distrobox_homes/Code_Editors/.config"

CODIUM_SNIPPETS_HOME="$DISTROBOX_CONFIG_HOME/VSCodium/User/snippets"
CODE_SNIPPETS_HOME="$DISTROBOX_CONFIG_HOME/Code/User/snippets"

VSCODIUM_PYTHON_SNIPPETS_FILE="$CODIUM_SNIPPETS_HOME/python.json"
VSCODE_PYTHON_SNIPPETS_FILE="$CODE_SNIPPETS_HOME/python.json"
SNIPPETS_BACKUP_FILE="$CODIUM_SNIPPETS_HOME/python_backup.json"

[[ ! -f $TEMP_FILE ]] && mkdir -p "$XDG_RUNTIME_DIR/app/snippet_gen"

cat "$VSCODIUM_PYTHON_SNIPPETS_FILE" > "$SNIPPETS_BACKUP_FILE" && "$TEMP_FILE" < "$VSCODIUM_PYTHON_SNIPPETS_FILE"

wl-paste > "$EDIT_FILE" && gedit "$EDIT_FILE" && wl-copy < "$EDIT_FILE"

INPUT=$(zenity  --forms --title="Add Snippet" \
				--text="<big><b>Enter snippet metadata.</b></big>" \
  				--separator="¨" \
    			--add-entry="Title" \
    			--add-entry="Prefix" \
				--add-entry="Description")
				#--add-entry="Content")

if [[ $? -eq 1 ]]; then
	notify-send --app-name="VSCode Snippets" --icon info \
		--urgency normal "VSCode Snippets" "Action cancelled: Enter snippet metadata "
  exit 1
fi


IFS='¨'
read -r -A SNIPPET_METADATA <<< "$INPUT"

export TITLE=${SNIPPET_METADATA[1]}
export PREFIX=${SNIPPET_METADATA[2]}
export DESCRIPTION=${SNIPPET_METADATA[3]}

export VSCODIUM_PYTHON_SNIPPETS_FILE
export TEMP_FILE

if [[ -z "$TITLE" || -z "$PREFIX" || -z "$DESCRIPTION" ]]; then
	notify-send --app-name="VSCode Snippets" --icon info \
		--urgency normal "VSCode Snippets" "Some of the metadata values was empty"
  exit 1
fi

#printf -v ESCAPED_BODY "%q" "${BODY}"

if [[ -f $VSCODIUM_PYTHON_SNIPPETS_FILE ]]; then
	wl-paste  | generate_vscode_snippet.py

	if [[ $? -eq 1 ]]; then
		notify-send --app-name="VSCode Snippets" --icon info \
		--urgency normal "VSCode Snippets" "Error parsing json"
	exit 1
	else
		cat "$TEMP_FILE" > "$VSCODIUM_PYTHON_SNIPPETS_FILE" && "$VSCODE_PYTHON_SNIPPETS_FILE" < "$TEMP_FILE"
		notify-send --app-name="VSCode Snippets" --icon info \
		--urgency normal "VSCode Snippets" "Your snippet was successfully registered";
	fi
	
	unset TITLE && \
	unset PREFIX && \
	unset DESCRIPTION && \
	unset VSCODIUM_PYTHON_SNIPPETS_FILE && \
	unset TEMP_FILE
else
	notify-send --app-name="VSCode Snippets" --icon error \
	--urgency normal "VSCode Snippets" "Error finding JSON snippet file, please check if VSCodium installed";
fi

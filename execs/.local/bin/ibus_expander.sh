#!/usr/bin/env bash

CONTENT="$(wl-paste --no-newline | sed "s/'/''/g")"

DATABASE="$HOME/.local/share/ibus-typing-booster/user.db"

[[ ! -f "$DATABASE" || ! -r "$DATABASE" || ! -w "$DATABASE" ]] && ibus restart

PAYLOAD=$(zenity --entry --text "" --title "IBus Expander" --width=400 --height=120)

function insert_ibus_suggestion(){

	if [[ -z "$PAYLOAD" ]]; then
		notify-send --app-name="IBus Expander" \
		--icon info \
		--urgency normal "IBus Expander" "You have not provided any identifier to the expansion" && exit 0;
	fi

	QUERY="INSERT INTO phrases (input_phrase, phrase, user_freq) VALUES ('$PAYLOAD', '$CONTENT', 1000000)"
	
	sqlite3 "$DATABASE" "$QUERY"
}

function test_insertion() {
	TEST_QUERY="SELECT input_phrase FROM phrases WHERE input_phrase=?"
	TEST_RESULT=$(sqlite3 "$DATABASE" "$TEST_QUERY" "$PAYLOAD")
	
	if [[ "$TEST_RESULT" == "$PAYLOAD" ]]; then
        notify-send --app-name="IBus Expander" --icon info --urgency normal "IBus Expander" "Your IBus Expander has been registered as: $PAYLOAD"
    else
        notify-send --app-name="IBus Expander" --icon error "IBus Expander" "ERROR: The IBus Expander registered are not the same"
    fi
}

if [[ -z $CONTENT ]]; then
	notify-send --app-name="IBus Expander" --icon info --urgency normal "IBus Expander" "No content on clipboard"
else
	insert_ibus_suggestion
fi

ibus restart

test_insertion



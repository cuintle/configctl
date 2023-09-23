#!/usr/bin/env python3

import json
from os import environ, _exit
from sys import stdin

content = stdin.read()

title = environ.get('TITLE')
prefix = environ.get('PREFIX')
description = environ.get('DESCRIPTION')
temp_file = environ.get('TEMP_FILE')

template = {title: {"prefix":prefix, "body": [content], "description": description}}

payload = json.loads(json.dumps(template))

with open(str(temp_file), encoding='utf-8', mode='r') as json_snippets_temp_file:
    try:
        snippets_file = json.load(json_snippets_temp_file)
    except json.JSONDecodeError:
        exit(1)
        
    snippets_file.update(payload)

with open(str(temp_file), encoding='utf-8', mode='w') as json_snippets_temp_file:
    try:
        json.dump(snippets_file, json_snippets_temp_file, indent=4)
    except json.JSONDecodeError:
        exit(1)
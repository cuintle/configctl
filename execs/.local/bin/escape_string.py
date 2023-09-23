#!/usr/bin/env python3

from sys import stdin, stdout

stdout.write(stdin.read().encode("unicode_escape").decode("utf-8")[1:-1])

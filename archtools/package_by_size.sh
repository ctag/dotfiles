#!/bin/bash
# Lists all officially installed packages by their collective file size

expac -s "%-30n %m" | sort -hk 2 | awk '{printf "%s %.0f MiB\n", $1, $2/1024/1024}' | column -t

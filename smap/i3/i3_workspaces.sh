#!/bin/bash

parse_json() {
        tr ',' '\n' \
                | awk '{ gsub(/[\{\}\[\]]/, "\n&\n"); print }' \
                | grep -ve '^ *$'
}

i3-msg -t get_workspaces | parse_json

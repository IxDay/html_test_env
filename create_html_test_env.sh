#!/bin/bash

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

TMP_PATH="/tmp/$(uuidgen)"
toto=$(mkdircd "$TMP_PATH/static/css" && pwd)
echo $toto
mkdir -p "$TMP_PATH/static/css"


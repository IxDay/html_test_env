#!/bin/bash

TMP_PATH="/tmp/html_test_env"

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

function init () {
	[[ -a "/tmp/html_test_env" ]] && exit

	mkdircd "$TMP_PATH/css" && touch main.css
	mkdircd "$TMP_PATH/img"
	mkdircd "$TMP_PATH/js" && touch main.js

	cd "$TMP_PATH"; 
	curl -O https://raw.github.com/IxDay/html_test_env/master/index.html;
	curl -O https://raw.github.com/IxDay/html_test_env/master/init.sh;
	chmod +x init.sh
}

function run () {
	cd "$TMP_PATH"	
	python -m SimpleHTTPServer 8008 & > "$TMP_PATH/logs" 2> "$TMP_PATH/logs_errors"  #run as a deamon
}

function clean () {
	cd "$HOME"
	rm -rf "$TMP_PATH" 2> /dev/null
}

function stop () {
	kill $(ps aux | grep "[S]impleHTTPServer 8008" | awk '{print $2}') 2> /dev/null
}

[ -z "$1" ] && init && run && exit

case "$1" in
	init )
		init
		;;
	run )
		run
		;;
	clean )
		clean
		;;
	* )
		echo "bad usage"
		exit
		;;
esac

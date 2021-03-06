#!/bin/bash

targetPath="$HOME/Downloads/zips"

function karabiner_link_config() {
	mv ~/.config/karabiner ~/bin/
	ln -s ~/bin/karabiner ~/.config/
	launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
}

function mcm_zip() {
	# -j remove path info
	rm $targetPath/mcm_rules.zip
	zip -j $targetPath/mcm_rules.zip ~/.config/karabiner/assets/complex_modifications/mcm_rules*.json
}

function mcm_unzip() {
	# -o overwrite -d change directory
	unzip -o $targetPath/mcm_rules.zip -d ~/.config/karabiner/assets/complex_modifications
}

function mcm_list() {
	# -l list
	unzip -l $targetPath/mcm_rules.zip
}

case $1 in 
-h)
	echo $(basename $0) '{zip|unzip|list}'
;;
zip)
	mcm_zip
;;
unzip)
	mcm_unzip
;;
list)
	mcm_list
;;
*)
	backup_rsync.sh
	mcm_zip
	mcm_list
;;
esac

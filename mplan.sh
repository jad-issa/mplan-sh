#!/bin/sh

# Note: ID is the filename

dir=$HOME/.mplan

case "$1" in
    "show")
	for f in $(ls $dir)
	do
	    echo "[0;31m----------------[0m"     # UI sugar
	    echo "[0;32mID:$f[0m"		     # UI sugar
	    cat $dir/$f				     # UI sugar
	done
	echo "[0;31m----------------[0m" 	     # UI sugar
	;;
    "create")
	ID=$RANDOM
	echo $2 > $dir/$ID
	echo "[0;32mID:$ID[0m"		     # UI sugar
	echo $2
	;;
    "remove")
	echo -e "[0;31mX[0m\t[0;32mID:$2[0m" # UI sugar
	echo -e "\t`cat $dir/$2`"		     # UI sugar
	[ "$2" = '*' ] && rm $dir/* || rm $dir/$2
	;;
    *)
	echo
	echo 'Usage:'
	echo '      mplan show               show current tasks'
	echo '      mplan create content     create a new task'
	echo '      mplan remove id          remove task by id (use \* for all)'
	echo '      mplan help               print this help'
	echo
esac

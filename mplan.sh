#!/bin/sh

dir=$HOME/.mplan

case "$1" in
    "show")
	for f in $(ls $dir)
	do
	    echo; echo $f
	    cat $dir/$f
	done
	;;
    "create")
	echo $2 > $dir/$RANDOM
	;;
    "remove")
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

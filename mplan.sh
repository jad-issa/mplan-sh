#!/bin/sh

# Create the directory and count file if they don't already exist
dir=$HOME/.mplan
[ ! -d "$dir" ] && mkdir -p "$dir"
[ ! -f "$dir/.count" ] && count=0 && echo $count > $dir/.count || count=$(cat $dir/.count)

case "$1" in
    "ls")
	for f in $(ls $dir); do
	    echo "[0;31m----------------[0m"      # Red line before every note
	    echo "[0;32mID: $f[0m"	              # Note ID in green
	    cat $dir/$f                               # Show the actual content
	done
	echo "[0;31m----------------[0m"          # Single red line at the end
	;;

    "add")
    let count++; echo $count > $dir/.count        # Increment count
    [ -z "$2" ] && cat > $dir/$count || echo $2 > $dir/$count # Possible use of stdin
    echo "[0;32mID: $count[0m"	              # ID in green
	cat $dir/$count
	;;

    "edit")
    [ -z "$EDITOR" ] && echo "EDITOR variable is empty, please set it" || 
        { [ -z "$2" ] && { let count++; echo $count > $dir/.count; $EDITOR $dir/$count; } ||
            $EDITOR $dir/$2; }
    ;;

    "rm")
	echo -e "[0;31mX[0m\t[0;32mID: $2[0m" # Red X and ID in green
	[ "$2" = "all" ] &&
        { rm $dir/*; echo 0 > $dir/.count; } ||
        { cat $dir/$2; rm $dir/$2; }
	;;

    *)
	echo 'Usage:'
	echo '      mplan ls                                  list current notes'
	echo '      mplan add content                          create a new note'
    echo '            Note: omit `content` to use standard input (via `cat`)'
    echo '      mplan edit ID                                edit note by ID'
    echo '            Note: omit `ID` to create a new note with the editor.'
	echo '      mplan rm ID                                remove note by ID'
    echo '            Or: `rm all` which resets the ID counter.'
	echo '      mplan help                                   print this help'
esac

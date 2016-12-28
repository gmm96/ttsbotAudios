#!/bin/bash
mod_extension="ogg"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <files>"
    exit 1
fi

for audio in "$@"
do
	ffmpeg -i $audio -ac 1 -c:a opus -b:a 16k tmp.ogg
	orig_name=`echo "$audio" | cut -d'.' -f1`
	orig_extension=`echo "$audio" | cut -d'.' -f2`
	mod_name="$orig_name.$mod_extension"
	mv tmp.ogg $mod_name
	if [ $orig_extension != $mod_extension ]; then
		rm $audio
	fi
	git add $mod_name
done

git commit -m "Uploading $@ to repo"
git push

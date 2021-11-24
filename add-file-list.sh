#!/bin/bash

echo -n "Adding file list to README.md... "

URL=$(git config --get remote.origin.url | sed 's#git@github.com:#https://github.com/#;s#\.git$##')

sed -i '/^## File List$/,$d' README.md

echo -e "## File List\n" >>README.md

for f in $(find data -type f)
do
	echo "- [$(basename $f)]($URL/raw/master/$f)" >>README.md
done

echo "done!"

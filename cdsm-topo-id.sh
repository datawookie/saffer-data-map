#!/bin/bash

# Directory of maps at http://www.madmappers.com/browse.php?TY=R.
#
# Do this to extract the ZIP files:
#
# $ for f in *.zip; do unzip -o $f; done
#
# The -o flag is important so that you are not prompted about overwriting the RSA50k_readme_first.txt file.

FOLDER=data/maps/topographic

BASEURL="https://www.globalmapper.com/datasets/R/South%20Africa/sgSA50k"

mkdir -p $FOLDER

CSV="cdsm-topo-id.csv"

while read -r filename
do
  echo "* $filename"

  filename=${filename}.zip
  filepath=$FOLDER/$(basename "$filename")

  url=$BASEURL/$filename
  #
  # URL encode spaces.
  #
  url=$(echo $url | sed 's/ /%20/')

  # echo $filepath
  # echo $url

  if test -f "$filepath"
  then
    echo "  - $filepath already exists."
  else
    echo "  - $filepath doesn't exist."
    echo "  - Downloading $url."
    wget -q -c -O $filepath $url
    if [ $? -eq 0 ]; then
        echo "  - ✅ Download success."
    else
        echo "  - 🚨 Download failed."
        exit 1
    fi
  fi
done < $CSV

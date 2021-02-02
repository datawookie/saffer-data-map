#!/bin/bash

GDAL_TRANSLATE="docker run -ti -v $(pwd):/data klokantech/gdal gdal_translate"

for f in *.sid
do
	$GDAL_TRANSLATE -of GTiff -co photometric=ycbcr -co compress=jpeg -co photometric=ycbcr -co tiled=yes -a_srs EPSG:4326 $f $(basename $f .sid).tif
done

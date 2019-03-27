#!/bin/bash
OUTPUT="vendor/asylum/overlay/common/frameworks/base/core/res/res/drawable-nodpi/"

OUTPUT_WALLPAPER="$OUTPUT/default_wallpaper.png"

WIDTH="$1"
HEIGHT="$2"

RES="$HEIGHT"
if [ "$HEIGHT" -lt "$WIDTH" ]; then
    RES="$WIDTH"
fi

mkdir -p $OUTPUT

REALWIDTH=$(echo "$RES * 1.125" | bc -l | cut -d'.' -f1)
RESOLUTION=""$REALWIDTH"x"$RES""
RESO=""$REALWIDTH"x"$REALWIDTH""

if [ ! -f $OUTPUT_WALLPAPER ]; then
    mogrify -resize $RESO -extent $RESOLUTION -colors 250 -gravity center -format png -path $OUTPUT vendor/asylum/wallpaper/default_wallpaper.svg
fi

WIDTH="$1"
HEIGHT="$2"
HALF_RES="$3"
OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HEIGHT" -lt "$WIDTH" ]; then
    IMAGEWIDTH="$HEIGHT"
else
    IMAGEWIDTH="$WIDTH"
fi

if [ "$HALF_RES" = "true" ]; then
    IMAGEWIDTH=$(expr $IMAGEWIDTH / 2)
fi
IMAGEHEIGHT="$IMAGEWIDTH"

RESOLUTION=""$IMAGEWIDTH"x"$IMAGEHEIGHT""

for part_cnt in 0 1 2
do
    mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part$part_cnt
done
tar xfp "vendor/asylum/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"
mogrify -resize $RESOLUTION -format png -colors 250 "$OUT/bootanimation/"*"/"*".jpg"

# Create desc.txt
echo "$IMAGEWIDTH $IMAGEHEIGHT" 24 > "$OUT/bootanimation/desc.txt"
cat "vendor/asylum/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$OUT/bootanimation"

zip -qr0 "$OUT/bootanimation.zip" .

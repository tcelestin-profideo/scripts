#!/bin/sh

icon="$HOME/.config/i3lock/nope.png"
img="/tmp/i3lock.png"

cp $icon /tmp/nope.png

tmp_icon="/tmp/nope.png"

scrot $img
# Pixelate image
convert $img -scale 10% -scale 1000% $img
convert $tmp_icon -scale 25% $tmp_icon
# Blur image
#convert $img -blur 0x4 500% $img
convert $img $tmp_icon -gravity center -composite $img

revert() {
    xset dpms 0 0 0
}

trap revert HUP INT TERM

i3lock -i $img

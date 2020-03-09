#!/bin/sh

icon="$HOME/.config/i3lock/other-nope.png"
emoji_file="$HOME/Documents/emoji_urls.txt"
img="/tmp/i3lock.png"
emoji="/tmp/emoji.png"
wallpapers="$HOME/Images/wallhallapapers/links.txt"
parameter="$1"

pixelate () {
    ## Take a screenshot
    scrot "$img"

    ## Pixelate screenshot
    convert $img -scale 20% -scale 500% $img
}

blur () {
    ## Blur screenshot
    convert $img -blur 0x2 500% $img
}

add_emoji () {
    ## Download an image from a list of urls
    wget $(shuf -n 1 $emoji_file) -O $emoji
    ## Resize the downloaded image
    convert $emoji -resize 65x65 $emoji
    ## Insert the image inside the screenshot
    convert $img $emoji -geometry +960+540 -composite $img
}

wallpaper () {
    ## Use wallpaper as image
    convert $(curl $(shuf -n 1 $wallpapers)) $img
    #convert $img -resize 1920x1080 $img
}

joke () {
    i3lock -u -p win -i $HOME/Images/joke.png
}

if [ -z $parameter ]
then
    echo "HELP:
    -p  #Pixelate
    -pe #Pixelate with emoji in the middle
    -b  #Blur
    -j  #Fake unlocked screen
    -w  #Wallpaper"
    exit
fi

if [ $parameter = "-b" ]
then
    blur
fi

if [ $parameter = "-p" ]
then
    pixelate
fi

if [ $parameter = "-pe" ]
then
    pixelate
    add_emoji
fi

if [ $parameter = "-w" ]
then
    wallpaper
fi

if [ $parameter = "-j" ]
then
    joke
fi

## Lock the screen
i3lock -ui $img

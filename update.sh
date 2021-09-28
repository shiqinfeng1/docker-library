#!/bin/bash

#!/usr/bin/env bash

CurrentDIR=$(cd "$(dirname "$0")" || exit;pwd)
ImagesList=$CurrentDIR/image-list.txt
ImagesListLen=$(cat ${ImagesList} | wc -l)
name=""

index=0
for image in $(<${ImagesList}); do
    array=(${image//:/ })
    image0=${array[0]}
    DIR_NAME="$(echo ${image0} | sed s@"/"@"-"@g)"
    if [ ! -d $DIR_NAME ]; then
        mkdir $DIR_NAME
        touch $DIR_NAME/Dockerfile
        echo "FROM "$image >> $DIR_NAME/Dockerfile
        echo "LABEL shiqinfeng1 <150627601@qq.com>" >> $DIR_NAME/Dockerfile
    else
        rm -rf $DIR_NAME/Dockerfile
        echo "FROM "$image >> $DIR_NAME/Dockerfile
        echo "LABEL shiqinfeng1 <150627601@qq.com>" >> $DIR_NAME/Dockerfile
    fi
done
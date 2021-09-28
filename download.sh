#!/bin/bash

#!/usr/bin/env bash

CurrentDIR=$(cd "$(dirname "$0")" || exit;pwd)
ImagesList=$CurrentDIR/image-list.txt

for image in $(<${ImagesList}); do
    array=(${image//:/ })
    image0=${array[0]}
    image2="$(echo ${image0} | sed s@"/"@"-"@g)"
    docker pull registry.cn-shanghai.aliyuncs.com/shiqinfeng1/$image2:latest
    docekr tag  registry.cn-shanghai.aliyuncs.com/shiqinfeng1/$image2:latest $image
    docker rmi  registry.cn-shanghai.aliyuncs.com/shiqinfeng1/$image2:latest
done
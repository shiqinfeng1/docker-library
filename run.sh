#!/bin/bash

#!/usr/bin/env bash

ImagesList=(
    quay.io/cephcsi/cephcsi:v3.3.1
    k8s.gcr.io/sig-storage/csi-node-driver-registrar:v2.0.1
    k8s.gcr.io/sig-storage/csi-resizer:v1.0.1
    k8s.gcr.io/sig-storage/csi-snapshotter:v4.0.0
    ceph/ceph:v15.2.11
    rook/ceph:v1.6.2
    k8s.gcr.io/sig-storage/csi-attacher:v3.0.2
)

OPTION=$1
cmd=$2
if [[ $cmd == "" ]]; then
   cmd="nerdctl"
fi
CurrentDIR=$(cd "$(dirname "$0")" || exit;pwd)
# ImagesList=$CurrentDIR/image-list.txt

function download_images() {
    for image in ${ImagesList[*]}; do
        array=(${image//:/ })
        image0=${array[0]}
        image2="$(echo ${image0} | sed s@"/"@"-"@g)"
        $cmd pull registry.cn-shanghai.aliyuncs.com/shiqinfeng1/$image2:latest
        $cmd tag  registry.cn-shanghai.aliyuncs.com/shiqinfeng1/$image2:latest $image
        $cmd rmi  registry.cn-shanghai.aliyuncs.com/shiqinfeng1/$image2:latest
    done
}

function update_images() {
    for image in ${ImagesList[*]}; do
        array=(${image//:/ })
        image0=${array[0]}
        DIR_NAME="$(echo ${image0} | sed s@"/"@"-"@g)"
        echo "image = $image0 ||| ver=${array[1]}"
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
}

if [ "${OPTION}" == "update" ]; then
	update_images
elif [ "${OPTION}" == "download" ]; then
	download_images
fi
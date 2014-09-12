#!/bin/sh

[ ! -z "$1" ] || {
  TAG_IMG=$1
    }
[ -z "$TAG_IMG" ] || {
  TAG_IMG=latest
    echo "Set default tag $TAG_IMG."
        exit 1
    }

sudo docker build -t tarmaker:django tarmaker || {
    echo "Something went wrong. Aborting."
        exit 1
    }

[ -f tarmaker/rootfs.tar ] && mv tarmaker/rootfs.tar tarmaker/rootfs.tar.old
[ -f tarmaker/rootfs.tar.md5 ] && mv tarmaker/rootfs.tar.md5 tarmaker/rootfs.tar.md5.old

sudo docker run --name builder-django tarmaker:django
sudo docker cp builder-django:/tmp/rootfs.tar ./
sudo docker cp builder-django:/tmp/rootfs.tar.md5 ./
sudo chown 1000:1000 rootfs*

if md5sum --check rootfs.tar.md5; then
    sudo docker rm -f builder-django &&\
    sudo docker rmi tarmaker:django &&\
    # We must wait until all removal is done before next step
    sudo docker build -t grengojbo/django:$TAG_IMG .
    #sudo docker build -t grengojbo/$1:test .
else
    echo "Checksum failed. Aborting."
    echo "Note: the tarmaker:django image and builder-django container have not been deleted."
    exit 1
fi

#!/usr/bin/env bash

USERID=$1
GROUPID=$2

export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64
yum remove -y freetype freetype-devel proj proj-devel gdal-libs gdal-devel
yum install -y harfbuzz-devel
yum localinstall -y /archives/freetype-2.8-33.x86_64.rpm /archives/proj-4.9.3-33.x86_64.rpm /archives/gdal-2.1.3-33.x86_64.rpm /archives/boost-1_62_0-33.x86_64.rpm /archives/mapnik-093fcee-33.x86_64.rpm

cd /tmp
tar axvf /archives/mapbox-geometry-v0.9.2.tar.gz
tar axvf /archives/mapbox-variant-v1.1.3.tar.gz
cp -r geometry.hpp-0.9.2/include/mapbox /usr/local/include
cp -r variant-1.1.3/include/mapbox /usr/local/include
tar axvf /archives/rpmbuild.tar
cd rpmbuild
cp /archives/mapnik-python-e5f107d8d459590829d50c976c7a4222d8f4737c.zip SOURCES/
rpmbuild -v -bb --clean SPECS/mapnik-python.spec
cp -f RPMS/x86_64/*.rpm /archives/
chown -R $USERID:$GROUPID /archives/*

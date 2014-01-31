#!/bin/bash

yum install -y proj-devel

# 
INSTALL_PATH=/opt

## GDAL
#APP=gdal-1.10.1
#GDAL_PATH=$INSTALL_PATH/$APP
#rm -rf $GDAL_PATH
#cd $INSTALL_PATH/src
#rm -rf gdal-*
#wget http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz
#tar xzf gdal-1.10.1.tar.gz
#cd gdal-1.10.1
#CC=gcc CXX='' \
#./configure \
#--prefix=$GDAL_PATH 2>&1 | tee $APP.config
#make 2>&1 | tee $APP.make
#make install 2>&1 | tee $APP.install

# PostgreSQL
APP=postgresql-9.3.2
PSQL_PATH=$INSTALL_PATH/$APP
rm -rf $PSQL_PATH
cd $INSTALL_PATH/src
rm -rf postgresql-*
wget http://ftp.postgresql.org/pub/source/v9.3.2/postgresql-9.3.2.tar.gz
tar xzf postgresql-9.3.2.tar.gz
cd postgresql-9.3.2
PYTHON=/opt/Python-2.7.6/bin/python2.7 \
CC=gcc \
CXX='' \
./configure \
--with-python \
--prefix=$PSQL_PATH 2>&1 | tee $APP.config
make world 2>&1 | tee $APP.make
make install-world 2>&1 | tee $APP.install

# PostGIS
APP=postgis-2.1.1
POSTGIS_PATH=$INSTALL_PATH/$APP
rm -rf $POSTGIS_PATH
cd $INSTALL_PATH/src
rm -rf postgis-*
wget http://download.osgeo.org/postgis/source/postgis-2.1.1.tar.gz
tar xzf postgis-2.1.1.tar.gz
cd postgis-2.1.1
CC=gcc CXX='' \
./configure \
--prefix=$POSTGIS_PATH 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install


#!/bin/bash

yum -y install \
autoconf \
automake \
bison \
blas blas-devel \
bzip2 bzip2-devel \
curl-devel \
erlang \
expat expat-devel \
flex \
gcc \
gcc-c++ \
gcc-gfortran \
gsl-devel \
js js-devel \
lapack lapack-devel \
libtool \
libxml2 libxml2-devel \
libxslt libxslt-devel \
libicu-devel \
libyaml \
libpng libpng-devel \
libjpeg libjpeg-devel \
make \
ncurses ncurses-devel \
openssl openssl-devel \
readline readline-devel \
sqlite sqlite-devel \
tk tk-devel \
zeromq zeromq-devel \
zlib zlib-devel

# -- create temporary directory for source
random=$(( RANDOM ))
TEMP_PATH=$( printf "/tmp/build-%05g" $random )
mkdir -p $TEMP_PATH

cp $TEMP_PATH

# ANTLR2
# ------
APP=antlr-2.7.7
wget http://www.antlr2.org/download/antlr-2.7.7.tar.gz
tar xzf antlr-2.7.7.tar.gz
cd antlr-2.7.7
# Bug in antlr-2.7.7
sed -i "13a #include <strings.h>" lib/cpp/antlr/CharScanner.hpp
sed -i "14a #include <cstdio>" lib/cpp/antlr/CharScanner.hpp
CC=gcc CXX='' ./configure \
--prefix=/usr/local \
--disable-csharp \
--disable-java \
--disable-python 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# UDUNITS
# -------
APP=udunits-2.1.24
wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.1.24.tar.gz
tar xzf udunits-2.1.24.tar.gz
cd udunits-2.1.24
CC=gcc CXX='' F77=gfortran ./configure \
--prefix=/usr/local 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# HDF4
# ----
APP=hdf-4.2.9
wget http://www.hdfgroup.org/ftp/HDF/releases/HDF4.2.9/src/hdf-4.2.9.tar.gz
tar xzf hdf-4.2.9.tar.gz
cd hdf-4.2.9
# Bug in configure script, need to define EGREP variable here
EGREP=egrep CC=gcc FC=gfortran F77=gfortran ./configure \
--prefix=/usr/local \
--disable-netcdf \
--enable-fortran \
--with-pic 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# HDF5
# ----
APP=hdf5-1.8.11
wget http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.11/src/hdf5-1.8.11.tar.gz
tar xzf hdf5-1.8.11.tar.gz
cd hdf5-1.8.11
CC=gcc FC=gfortran CXX='' ./configure \
--prefix=/usr/local \
--enable-fortran \
--with-pic 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# netCDF4
# -------
APP=netcdf-4.3.0
wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-4.3.0.tar.gz
tar xzf netcdf-4.3.0.tar.gz
cd netcdf-4.3.0
CC=gcc ./configure \
--prefix=/usr/local \
--enable-static \
--enable-shared \
--enable-netcdf4 \
--enable-hdf4 \
--with-pic 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# libevent2
# ---------
APP=libevent-2.0.21-stable
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xzf libevent-2.0.21-stable.tar.gz 
cd libevent-2.0.21-stable
CC=gcc CXX='' ./configure \
--prefix=/usr/local 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# gsw-teos
# --------
APP=gsw-teos
git clone https://github.com/lukecampbell/gsw-teos.git
cd gsw-teos/
bash autogen.sh 
./configure \
--prefix=/usr/local 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

# Python2.7
# ---------
wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xjpvf Python-2.7.5.tar.bz2 
cd Python-2.7.5
./configure \
--prefix=/usr/local 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make altinstall 2>&1 | tee $APP.install
cd $TEMP_PATH

wget --no-check-certificate http://pypi.python.org/packages/source/d/distribute/distribute-0.6.35.tar.gz
tar xzvf distribute-0.6.35.tar.gz
cd distribute-0.6.35
python2.7 setup.py install
easy_install-2.7 virtualenv

# RabbitMQ
# --------
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.0/rabbitmq-server-3.2.0-1.noarch.rpm
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
rpm -Uvh rabbitmq-server-3.2.0-1.noarch.rpm
rabbitmq-plugins enable rabbitmq_management

# CouchDB
# -------
wget --no-check-certificate http://mirror.olnevhost.net/pub/apache/couchdb/source/1.4.0/apache-couchdb-1.4.0.tar.gz
tar xzvf apache-couchdb-1.4.0.tar.gz
cd apache-couchdb-1.4.0
./configure \
-prefix=/usr/local \
-with-erlang=/usr/lib64/erlang/usr/include 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install
cd $TEMP_PATH

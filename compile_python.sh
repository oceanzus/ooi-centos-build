#!/bin/bash

# 
INSTALL_PATH=/opt

# 
APP=Python-2.7.6
PYTHON_PATH=$INSTALL_PATH/$APP
rm -rf $PYTHON_PATH
cd $INSTALL_PATH/src
rm -rf Python-*
wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
tar xzvf Python-2.7.6.tgz
cd Python-2.7.6
CC=gcc CXX='' \
./configure \
--enable-shared \
--prefix=$PYTHON_PATH 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make altinstall 2>&1 | tee $APP.install

curl -O http://python-distribute.org/distribute_setup.py
python distribute_setup.py
easy_install pip
pip install virtualenv
pip install virtualenvwrapper

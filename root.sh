yum -y install \
libxml2 libxml2-devel \
libxslt libxslt-devel \
openssl openssl-devel \
libicu-devel \
libyaml \
libpng libpng-devel \
libjpeg libjpeg-devel \
erlang erlang-devel \
expat expat-devel \
blas blas-devel \
lapack lapack-devel \
zlib zlib-devel \
bzip2 bzip2-devel \
ncurses ncurses-devel \
sqlite sqlite-devel \
readline readline-devel \
tk tk-devel \
zeromq zeromq-devel \
js js-devel
#libevent libevent-devel \
#udunits2 udunits2-devel \
#hdf5 hdf5-devel \
#netcdf netcdf-devel \

yum -y install autoconf automake libtool

wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xzvf libevent-2.0.21-stable.tar.gz 
cd libevent-2.0.21-stable
mkdir /opt/libevent-2.0.21-stable
./configure --prefix=/opt/libevent-2.0.21-stable
make
make install

git clone https://github.com/lukecampbell/gsw-teos.git
cd gsw-teos/
bash autogen.sh 
./configure --prefix=/usr/local
make
make install

wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xjpvf Python-2.7.5.tar.bz2 
cd Python-2.7.5
./configure --prefix=/usr/local
make && make altinstall

wget --no-check-certificate http://pypi.python.org/packages/source/d/distribute/distribute-0.6.35.tar.gz
tar xzvf distribute-0.6.35.tar.gz
cd distribute-0.6.35
python2.7 setup.py install
easy_install-2.7 virtualenv

wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.0/rabbitmq-server-3.2.0-1.noarch.rpm
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
yum install rabbitmq-server-3.1.5-1.noarch.rpm
rabbitmq-plugins enable rabbitmq_management

wget --no-check-certificate http://mirror.olnevhost.net/pub/apache/couchdb/source/1.4.0/apache-couchdb-1.4.0.tar.gz
tar xzvf apache-couchdb-1.4.0.tar.gz
cd apache-couchdb-1.4.0
mkdir /opt/apache-couchdb-1.4.0
./configure  --with-erlang=/usr/lib64/erlang/usr/include --prefix=/opt/apache-couchdb-1.4.0
make
make install


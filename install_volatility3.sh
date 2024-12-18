#!/bin/bash

# vai para pasta home padrão
cd

# instala dependências
sudo apt-get install build-essential autoconf dwarfdump git subversion pcregrep libpcre++-dev python-dev -y

# Instala o Distorm
cd
wget https://github.com/gdabah/distorm/archive/refs/tags/3.5.2b.zip
unzip 3.5.2b.zip
cd distorm-3.5.2b
python setup.py build
python setup.py build install

# Instala o Yara
cd
sudo apt-get install automake libtool make gcc pkg-config
wget https://github.com/VirusTotal/yara/archive/refs/tags/v4.5.2.tar.gz
tar -zxf v4.5.2.tar.gz
cd yara-4.5.2
./bootstrap.sh
./configure
make
sudo make install

# Instala o PyCrypto
cd
wget https://github.com/pycrypto/pycrypto/archive/refs/tags/v2.7a1.zip
unzip v2.7a1.zip
cd pycrypto-2.7a1
python setup.py build
$ sudo python setup.py build install


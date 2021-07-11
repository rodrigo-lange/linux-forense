#!/bin/bash

#vai para pasta home
cd ~

#atualiza e instala os pacotes essenciais
apt update
apt dist-upgrade -y
apt upgrade -y
apt autoremove
apt install linux-headers-$(uname -r)
apt install python3-pip python-setuptools build-essential python-dev -y

#instala o PIP2
cd ~
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python get-pip.py

#instala o volatility
cd ~
git clone https://github.com/volatilityfoundation/volatility.git 
cd volatility 
chmod +x vol.py
python setup.py build 
python setup.py build install

#instala as dependencias do volatility
pip3 install --upgrade setuptools
pip2 install --upgrade setuptools
pip2 install pycrypto
pip2 install distorm3==3.4.4 

#instala plaso e log2timeline
cd ~
git clone https://github.com/log2timeline/plaso.git
cd plaso
python3 setup.py build
python3 setup.py build install
pip3 install -r requirements.txt
pip3 install fakeredis

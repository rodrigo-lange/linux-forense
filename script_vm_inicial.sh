#!/bin/bash

# entra na pasta home
cd ~

# configura o teclado ABNT2
echo setxkbmap -model abnt2 -layout br >> .zshrc

# configura para reiniciar os serviços automaticamente
export DEBIAN_FRONTEND=noninteractive

# atualiza a VM
apt update
apt dist-upgrade --fix-missing -y

# Instala o Volatility
# Instruções em: https://seanthegeek.net/1172/how-to-install-volatility-2-and-volatility-3-on-debian-ubuntu-or-kali-linux/
# instala os pacotes essenciais do Volatility
sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata

# instala o pip para Python 2
sudo apt install -y python2 python2.7-dev libpython2-dev
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo python2 -m pip install -U setuptools wheel

# instala o Volatility 2 e suas dependências do Python
python2 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
sudo python2 -m pip install yara
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git

# instala o pip para o Python 3
sudo apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel

# instala o Volatility 3 e suas dependências do Python
python3 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git

# baixa o perfil do Linux do volatility
cd /usr/local/lib/python2.7/dist-packages/volatility/plugins/overlays/linux/
wget -N https://github.com/rodrigo-lange/linux-forense/raw/main/profile.zip

# instala plaso e log2timeline
apt install plaso python3-plaso

# volta para pasta root
cd ~

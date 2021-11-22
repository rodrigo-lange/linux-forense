#!/bin/bash

#entrar na pasta home
cd ~

#configurar o teclado ABNT2
echo setxkbmap -model abnt2 -layout br >> .zshrc

#configura para reiniciar os serviços automaticamente
export DEBIAN_FRONTEND=noninteractive

#instala os pacotes essenciais
apt install python3-pip python-setuptools build-essential python2-dev dwarfdump -y

#atualiza a VM
apt update
apt dist-upgrade --fix-missing -y
apt autoremove -y

#instala o PIP2
cd ~
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py

#instala todas dependencias do volatility
pip3 install --upgrade setuptools
pip2 install --upgrade setuptools
pip2 install pycrypto
pip2 install distorm3==3.4.4 

#instala o volatility
cd ~
git clone https://github.com/volatilityfoundation/volatility.git 
cd volatility 
chmod +x vol.py

#baixa o perfil do volatility
cd ~/volatility/volatility/plugins/overlays/linux/
wget -N https://github.com/rodrigo-lange/linux-forense/raw/main/profile.zip

#instala plaso e log2timeline
cd ~
git clone https://github.com/log2timeline/plaso.git
cd plaso
python3 setup.py build
python3 setup.py build install
pip3 install -r requirements.txt
pip3 install fakeredis
pip3 install mock

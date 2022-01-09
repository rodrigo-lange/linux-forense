#!/bin/bash

# entra na pasta home
cd ~

# configura o teclado ABNT2
echo setxkbmap -model abnt2 -layout br >> .zshrc

# configura para reiniciar os serviços automaticamente
export DEBIAN_FRONTEND=noninteractive

# atualiza a VM
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade --fix-missing -y

# instala plaso e log2timeline (por incompatibilidade entre as bibliotecas Yara do Volatility e do Plaso, optou-se pela instalação via docker)
#sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt-get install -y docker.io
#sudo systemctl enable docker --now
#docker pull log2timeline/plaso
cd ~
git clone https://github.com/log2timeline/plaso.git
cd plaso
python3 setup.py build
python3 setup.py build install
pip3 install -r requirements.txt
pip3 install fakeredis
pip3 install mock

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
sudo python2 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
sudo python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git

# baixa o perfil do Linux do volatility
cd /usr/local/lib/python2.7/dist-packages/volatility/plugins/overlays/linux/
sudo wget -N https://github.com/rodrigo-lange/linux-forense/raw/main/profile.zip

# volta para pasta root e remove pacotes não necessários
apt autoremove -y
cd ~

#!/bin/bash

# entra na pasta home
cd ~

# desabilita a proteção de tela
echo xset -dpms >> .zshrc
echo xset s off >> .zshrc

# configura o teclado ABNT2
echo setxkbmap -model abnt2 -layout br >> .zshrc

# configura para reiniciar os serviços automaticamente
export DEBIAN_FRONTEND=noninteractive

# atualiza a VM
echo " "
echo "========================================================="
echo "Atualizando a VM"
echo "========================================================="
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade --fix-missing -y
sudo apt install dkms -y
 
# instala plaso e log2timeline
echo " "
echo "========================================================="
echo "Instalando Plaso e Log2Timeline"
echo "========================================================="
cd ~
apt install docker.io -y
docker pull log2timeline/plaso

# Instala o Volatility
echo " "
echo "========================================================="
echo "Instalando Volatility"
echo "========================================================="
# Instruções em: https://seanthegeek.net/1172/how-to-install-volatility-2-and-volatility-3-on-debian-ubuntu-or-kali-linux/
# instala os pacotes essenciais do Volatility 2.6
cd ~
sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata

# instala o pip para Python 2
sudo apt install -y python2 python2.7-dev libpython2-dev
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo python2 -m pip install -U setuptools wheel
python2 -m pip install --upgrade pip

# instala o Volatility 2 e suas dependências do Python
sudo python2 -m pip install -U distorm3 yara pycrypto pillow openpyxl pytz ipython capstone
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
sudo python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git

# baixa o perfil do Linux do volatility
cd /usr/local/lib/python2.7/dist-packages/volatility/plugins/overlays/linux/
sudo wget -N https://github.com/rodrigo-lange/linux-forense/raw/main/profile.zip

# volta para pasta root e remove pacotes não necessários
echo " "
echo "========================================================="
echo "Removendo pacotes desnecessários"
echo "========================================================="
apt autoremove -y
cd ~
echo "========================================================="
echo "Instalação finalizada com sucesso"
echo "========================================================="

# Para instalar a caveira no prompt
# sed -i 's/prompt_symbol=㉿/prompt_symbol=💀/' ~/.zshrc
# source ~/.zshrc

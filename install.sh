#!/bin/bash
echo "Installing. . . . . "

sudo apt update -qq > /dev/null 2>&1
sudo apt-get install curl wget zip git nmap figlet toilet tor python pip3 ffmpeg pv -y curl > /dev/null 2>&1
echo "ROBCO INDUSTRIES (TM) UNIFIED OPERATIONAL SYSTEM INSTALLATION" | pv -qL 50
echo "CONFIGURING PACKAGES" | pv -qL 30
sudo apt-get install gnome-terminal ffmpeg
echo "TERMINAL COMPONENT NECESSARY" | pv -qL 30
echo "64.KB" | pv -qL 40
[ ! -d "$HOME/.fallout" ] && mkdir -p "$HOME/.fallout"

for item in *; do
  [ -d "$item" ] && cp -r "$item" "$HOME/.fallout/" || cp "$item" "$HOME/.fallout/"
done

if [[ "$SHELL" == *"zsh"* ]]; then
  RC_FILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
  RC_FILE="$HOME/.bashrc"
else
  exit 1
fi

grep -q "python $HOME/.fallout/init.py" "$RC_FILE" || echo "python $HOME/.fallout/init.py" >> "$RC_FILE"




cp -r audio $HOME/.local/
git clone https://github.com/bissisoft/torall.git
mv torall $HOME/.local/
cd $HOME/.local/torall
chmod +x build.sh
sudo ./build.sh
cd $HOME
git clone https://github.com/ARCANGEL0/EzyMap.git
mv EzyMap $HOME/.local/
cd $HOME/.local/EzyMap 
chmod +x install.sh
sudo ./install.sh 
cd $HOME;

echo "ROBCO UNIFIED OPERATIONAL SYSTEM IS READY!" | pv -qL 20
sleep 5
clear 
cd $HOME;
tmux

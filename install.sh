#!/bin/bash
echo "Installing  . . . . "

detect_pkg() {
    if command -v brew &>/dev/null; then
        echo "brew"
    elif command -v apt-get &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v pacman &>/dev/null; then
        echo "pac"
    elif command -v zypper &>/dev/null; then
        echo "zyp"
    else
        echo "unk"
    fi
}

pm=$(detect_pkg)

run_install() {
    local pkg="$1"
    case $pm in
        brew) brew install "$pkg" ;;
        apt) sudo apt-get install "$pkg" -y ;;
        dnf) sudo dnf install "$pkg" -y ;;
        pac) sudo pacman -S --noconfirm "$pkg" ;;
        zyp) sudo zypper install -y "$pkg" ;;
    esac
}

q_install() {
    local pkg="$1"
    case $pm in
        brew) brew install "$pkg" &>/dev/null ;;
        apt) sudo apt-get install "$pkg" -y &>/dev/null ;;
        dnf) sudo dnf install "$pkg" -y &>/dev/null ;;
        pac) sudo pacman -S --noconfirm "$pkg" &>/dev/null ;;
        zyp) sudo zypper install -y "$pkg" &>/dev/null ;;
    esac
}

if [ "$pm" = "unk" ]; then
    echo "uhh idk ur system. good luck lol"
    exit 1
fi

echo "found: $pm"

if [ "$pm" = "apt" ]; then
    sudo apt update -qq &>/dev/null
fi

pkgs="curl wget zip git nmap figlet toilet python3 python3-pip ffmpeg pv"
[ "$pm" = "brew" ] && pkgs="curl wget zip git nmap figlet toilet python3 pip ffmpeg pv"

for x in $pkgs; do
    q_install "$x"
done

echo "ROBCO INDUSTRIES (TM) UNIFIED OPERATIONAL SYSTEM INSTALLATION" | pv -qL 50
echo "CONFIGURING PACKAGES" | pv -qL 30

run_install "gnome-terminal"
run_install "ffmpeg"

echo "TERMINAL COMPONENT NECESSARY" | pv -qL 30
echo "64.KB" | pv -qL 40

[ ! -d "$HOME/.fallout" ] && mkdir -p "$HOME/.fallout"

for item in *; do
    [ -d "$item" ] && cp -r "$item" "$HOME/.fallout/" || cp "$item" "$HOME/.fallout/"
done

RC_FILE="$HOME/.bashrc"
[ "$SHELL" = *"zsh"* ] && RC_FILE="$HOME/.zshrc"

grep -q "python3 $HOME/.fallout/init.py" "$RC_FILE" || echo "python3 $HOME/.fallout/init.py" >> "$RC_FILE"

cd $HOME

if command -v torctl-bridged &>/dev/null; then
    echo "torctl already there"
else
    if command -v systemctl &>/dev/null; then
        sudo systemctl stop tor 2>/dev/null
    fi

    case $(uname -m) in
        x86_64) arch=amd64 ;;
        aarch64|arm64) arch=arm64 ;;
        *) arch=amd64 ;;
    esac

    url="https://github.com/JohnMcLaren/torctl-bridged/releases/download/torctl-bridged/torctl-bridged_0.5.7-1_${arch}.deb"

    case $pm in
        apt) 
            wget -q "$url"
            sudo apt install torctl-bridged_0.5.7-1_${arch}.deb
            rm -f torctl-bridged_*.deb
            ;;
        dnf)
            wget -q "$url"
            sudo dnf install torctl-bridged_0.5.7-1_${arch}.deb -y
            rm -f torctl-bridged_*.deb
            ;;
        pac)
            wget -q "$url"
            sudo pacman -U torctl-bridged_0.5.7-1_${arch}.deb --noconfirm
            rm -f torctl-bridged_*.deb
            ;;
        brew)
            echo "brew user: install torctl manually lol"
            ;;
    esac
fi

if [ -d "$HOME/.local/EzyMap" ]; then
    echo "EzyMap already here"
else
    git clone https://github.com/ARCANGEL0/EzyMap.git "$HOME/.local/EzyMap"
    cd "$HOME/.local/EzyMap"
    chmod +x install.sh
    sudo ./install.sh
fi

cd $HOME

echo "ROBCO UNIFIED OPERATIONAL SYSTEM IS READY!" | pv -qL 20
sleep 5
clear
cd $HOME
tmux

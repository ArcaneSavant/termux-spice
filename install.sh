# cspell:words ArcaneSavant autoindent libqrencode linenumbers nanorc neofetch netrc ohmybash publickey tabsize tabstospaces termux

#!/data/data/com.termux/files/usr/bin/bash

########################################################################
# "Termux Spice" Install Script
# Execute install.sh
#
# Copyright (C) 2024 ArcaneSavant
#
# Author(s): ArcaneSavant <https://github.com/ArcaneSavant>
#
# Webpage  : https://github.com/ArcaneSavant/termux-spice
#
# Enjoy "Termux Spice"!
#
# License: MIT License
########################################################################

# Intro
printf '\n%s\n' "© 2024 ArcaneSavant"
printf '%s\n' "https://github.com/ArcaneSavant/termux-spice"
printf '%s\n' "Spice Up Termux, Anytime!"

# Setup Storage
printf '\n%s\n' "Grant Storage Permission if Asked"
termux-setup-storage
sleep 5

# Update, Upgrade, & Install Packages
printf '\n%s\n' "→ Updating & Upgrading Pre-installed Packages"
pkg update -y && pkg upgrade -y

printf '\n%s\n' "→ Installing Selected Packages"
pkg install -y bash-completion ffmpeg git git-lfs gh libqrencode man nano openssh openssh-sftp-server python tree
sleep 1

# Upgrade & Install Python Packages
printf '\n%s\n' "→ Upgrading Pre-installed Python Packages"
pip --disable-pip-version-check list --outdated --format=json |
  python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" |
  xargs --max-args=1 pip install --upgrade 2>/dev/null

printf '\n%s\n' "→ Installing Selected Python Packages"
pip install yt-dlp
sleep 1

# Clone Termux Spice repository
printf '\n%s\n' "→ Cloning Termux Spice Repo"
git clone https://github.com/ArcaneSavant/termux-spice.git "${HOME}/archives/termux-spice"
sleep 1

# Configure yt-dlp
printf '\n%s\n' "→ Configuring yt-dlp"

if [ -f "${HOME}/.config/yt-dlp/config" ]; then
  printf '%s\n' "→ Backing Up the Old yt-dlp Configuration File"
  mv "${HOME}/.config/yt-dlp/config" "${HOME}/.config/yt-dlp/config.$(date +%Y%m%d%H%M%S).bak"
fi

mkdir -p "${HOME}/.config/yt-dlp"
touch "${HOME}/.config/yt-dlp/config"
sleep 1

# Configure termux-url-opener
printf '\n%s\n' "→ Configuring termux-url-opener"

if [ -f "${HOME}/bin/termux-url-opener" ]; then
  printf '%s\n' "→ Backing Up the Old termux-url-opener File"
  mv "${HOME}/bin/termux-url-opener" "${HOME}/bin/termux-url-opener.$(date +%Y%m%d%H%M%S).bak"
fi

mkdir -p "${HOME}/bin"
cp "${HOME}/archives/termux-spice/home/bin/termux-url-opener" "${HOME}/bin"
sleep 1

# Create .netrc File
printf '\n%s\n' "→ Creating .netrc File"

if [ -f "${HOME}/.netrc" ]; then
  printf '%s\n' "→ Backing Up the Old .netrc File"
  mv "${HOME}/.netrc" "${HOME}/.netrc.$(date +%Y%m%d%H%M%S).bak"
fi

touch "${HOME}/.netrc"
chmod a-rwx,u+rw "${HOME}/.netrc"
sleep 1

# Install oh-my-bash
printf '\n%s\n' "→ Installing oh-my-bash"

git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash
sleep 1

# Configure oh-my-bash
printf '\n%s\n' "→ Configuring ohmybash"

if [ -f "${HOME}/.bashrc" ]; then
  printf '%s\n' "→ Backing Up the Old bash Configuration File"
  mv "${HOME}/.bashrc" "${HOME}/.bashrc.$(date +%Y%m%d%H%M%S).bak"
fi

cp "${HOME}/.oh-my-bash/templates/bashrc.osh-template" "${HOME}/.bashrc"
sed -i '/^OSH_THEME/d' "${HOME}/.bashrc"
sed -i '6iOSH_THEME="sexy"' "${HOME}/.bashrc"
sleep 1

# Configure openssh
printf '\n%s\n' "→ Configuring openssh"

if [ -f "${HOME}/.ssh/config" ]; then
  printf '%s\n' "→ Backing Up the Old openssh Configuration File"
  mv "${HOME}/.ssh/config" "${HOME}/.ssh/config.$(date +%Y%m%d%H%M%S).bak"
fi

mkdir -p "${HOME}/.ssh"
touch "${HOME}/.ssh/config"
{
  printf '%s\n' "Host github.com"
  printf '%s\n' "  UpdateHostKeys ask"
  printf '%s\n' "  PreferredAuthentications publickey"
  printf '%s\n' "  IdentityFile ~/.ssh/id_ed25519"
} >"${HOME}/.ssh/config"

printf '%s\n' "Please Modify This Configuration if Needed."
sleep 1

# Configure nano
printf '\n%s\n' "→ Configuring nano"

if [ -f "${HOME}/.config/nano/nanorc" ]; then
  printf '%s\n' "→ Backing Up the Old nano Configuration File"
  mv "${HOME}/.config/nano/nanorc" "${HOME}/.config/nano/nanorc.$(date +%Y%m%d%H%M%S).bak"
fi

mkdir -p "${HOME}/.config/nano"
touch "${HOME}/.config/nano/nanorc"
{
  printf '%s\n' "set autoindent"
  printf '%s\n' "set linenumbers"
  printf '%s\n' "set locking"
  printf '%s\n' "set tabsize 2"
  printf '%s\n' "set tabstospaces"
} >"${HOME}/.config/nano/nanorc"
sleep 1

# Configure git & git-lfs
printf '\n%s\n' "→ Configuring git & git-lfs"

if [ -f "${HOME}/.gitconfig" ]; then
  printf '%s\n' "→ Backing Up the Old git Configuration File"
  mv "${HOME}/.gitconfig" "${HOME}/.gitconfig.$(date +%Y%m%d%H%M%S).bak"
fi

touch "${HOME}/.gitconfig"
git lfs install
git config --global core.autocrlf input
git config --global core.editor nano
git config --global init.defaultBranch main

printf '%s\n' "Please Set Your User Name and Email Address Manually."
sleep 1

# Restart
printf '\n%s\n' "✔ Done."
printf '%s\n' "Please Restart Termux App."
printf '%s\n' "Thank You!"

exit

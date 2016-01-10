#!/usr/bin/env sh

#
# README
# - This script assumes apache2 is installed with default settings
#

# Install all necessary packages
aptitude install zsh curl git-all xclip -y

# Install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# Create home folder structure
mkdir -p bin git-repos/personal programs/hub


# Set up personal shell-config repo
pushd $HOME/git-repos/personal
git clone https://github.com/olsonpm/shell-config.git
cd shell-config
./create-symlinks.sh
printf '\n# Loads personal shell-config extensions\n. $HOME/.sh_exts.sh\n' >> ~/.zshrc
. $HOME/.zshrc
popd


#------------------------#
# Install other programs #
#------------------------#

# Unfortunately there exists no hub version manager nor does there exist a latest tag
#   to grab the version from.  Updating is then left as manual step.
pushd programs/hub
curl -L https://github.com/github/hub/releases/download/v2.2.2/hub-linux-amd64-2.2.2.tgz \
| tar -xz
popd
ln -s $HOME/programs/hub/hub-linux-amd64-2.2.2/bin/hub $HOME/bin/hub

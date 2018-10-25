#!/bin/bash

set -e
set -x

sudo apt-get install -y debian-archive-keyring

curl https://wiki.vyos.net/so3group_maintainers.key > /tmp/so3group_maintainers.key
sudo gpg --import /tmp/so3group_maintainers.key
rm -f /tmp/so3group_maintainers.key

#sudo rsync -az --progress keyring.debian.org::keyrings/keyrings/ /usr/share/keyrings/
sudo apt-key update

WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

$WRAPPER begin
# The package repository for helium has been moved to dev.packages.vyos.net/legacy/repos/vyos
$WRAPPER set system package repository community components 'main'
$WRAPPER set system package repository community distribution 'helium'
$WRAPPER set system package repository community url 'http://dev.packages.vyos.net/repositories/legacy/vyos'
$WRAPPER set system package repository squeeze components 'main contrib non-free'
$WRAPPER set system package repository squeeze distribution 'squeeze'
$WRAPPER set system package repository squeeze url 'http://archive.debian.org/debian'
$WRAPPER commit
$WRAPPER save
$WRAPPER end

#sudo aptitude -y update

#!/bin/bash

# vim: filetype=sh:tabstop=2:shiftwidth=2:expandtab

# Following the following official golang instructions:
# https://golang.org/doc/install

readonly PROGNAME=$(basename $0)
readonly PROJECTDIR="$( cd "$(dirname "$0")" ; pwd -P )"

readonly OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
readonly ARCH="$(uname -m)"
if [ -f "/etc/os-release" ]; then
  source os_release
fi

readonly TMP_DIR="/tmp"
readonly BIN_DIR="$HOME/bin"
readonly CURL_CMD=`which curl`
readonly UNZIP_CMD=`which unzip`

readonly TERRAFORM_VERSION="0.6.14"
readonly DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
readonly DOWNLOADED_FILE="$TMP_DIR/terraform.zip"

INSTALL_CMD="$UNZIP_CMD $DOWNLOADED_FILE -d /usr/local/bin"
REMOVE_CMD="rm -rf /usr/local/bin/terraform*"

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  echo "Will attempt to install using sudo..."
  INSTALL_CMD="sudo ${INSTALL_CMD}"
  REMOVE_CMD="sudo ${REMOVE_CMD}"
fi


echo ""
echo "Remove any residual artitfacts from previous installs..."
rm -rf $DOWNLOADED_FILE
$REMOVE_CMD

echo ""
echo "Installing Terraform"
$CURL_CMD -o $DOWNLOADED_FILE $DOWNLOAD_URL
$INSTALL_CMD

###
# Finished!
###
echo ""
#echo 'now you can source $HOME/.golang_profile'
echo 'now you can start using terraform'

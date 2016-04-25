#!/bin/bash

# vim: filetype=sh:tabstop=2:shiftwidth=2:expandtab

readonly PROGNAME=$(basename $0)
readonly PROGDIR="$( cd "$(dirname "$0")" ; pwd -P )"
readonly ARGS="$@"

# pull in utils
source "${PROGDIR}/utils.sh"


# Make sure we have all the right stuff
prerequisites() {
  # we want to be root to install / uninstall
  if [ "$EUID" -ne 0 ]; then
    error "Please run as root"
    exit 1
  fi
}


# Uninstall Terraform
uninstall_terraform() {
  echo ""
  echo "Remove any residual artitfacts from previous installs..."
  rm -rf $DOWNLOADED_FILE

  echo ""
  echo "Removing Terraform executables (incl. plugins)"
  cd "$INSTALL_DIR" || exit 1
  rm -rf terraform*
}


main() {
  # Be unforgiving about errors
  set -euo pipefail
  readonly SELF="$(absolute_path $0)"
  prerequisites
  uninstall_terraform
}

[[ "$0" == "$BASH_SOURCE" ]] && main

#!/bin/bash

## Copyright 2015 DevOpsGuys
## Licensed under the MIT license
## Pull Requests Accepted :)

DEB_OR_UBU=$(lsb_release -ds | cut -d " " -f 1)
INSTALLED_VERSION=$(dpkg -s libc6 | grep Version | awk '{ print $2 }')
FIXED_VERSION=""
if [ "$DEB_OR_UBU" == "Ubuntu" ]; then
  UBUNTU_RELEASE=$(lsb_release -sr | cut -d '.' -f 1)
  case $UBUNTU_RELEASE in
    10)
      FIXED_VERSION=2.11.1-0ubuntu7.20 ;;
    12)
      FIXED_VERSION=2.15-0ubuntu10.10 ;;
    14)
      FIXED_VERSION=2.19-0ubuntu6 ;;
  esac
else
  DEBIAN_RELEASE=$(lsb_release -sr | cut -c 1)
  case $DEBIAN_RELEASE in
    6)
      FIXED_VERSION=2.11.3-4+deb6u4 ;;
    7)
      FIXED_VERSION=2.13-38+deb7u7 ;;
    8)
      FIXED_VERSION=2.19-13 ;;
  esac
fi

dpkg --compare-versions $INSTALLED_VERSION gt $FIXED_VERSION
if [ ! $? -eq 0 ] ; then
  echo Installed is $INSTALLED_VERSION, should be $FIXED_VERSION
  exit 2
else
  echo Installed is $INSTALLED_VERSION, looks OK.
  exit 0
fi 

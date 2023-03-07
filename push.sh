#!/bin/bash

set -e

echo "Install dependencies"
sudo gem install package_cloud

# List of RPM distributions to push to
RPM_DSTS="sles/12.2 sles/12.3 sles/15.0 sles/12.4 sles/12.5 sles/15.1 sles/15.2 sles/15.3 sles/15.4 opensuse/13.1 opensuse/13.2 opensuse/42.1 opensuse/42.2 opensuse/42.3 opensuse/15.0 opensuse/15.1 opensuse/15.2 opensuse/15.3 opensuse/15.4 fedora/27 fedora/28 fedora/29 fedora/30 fedora/31 fedora/32 fedora/33 fedora/34 fedora/35 fedora/36 fedora/37 el/7 el/8 el/9 ol/7 ol/8 ol/9 scientific/7"

# List of DEB distributions to push to
DEB_DSTS="elementaryos/freya elementaryos/loki elementaryos/juno elementaryos/hera raspbian/wheezy raspbian/jessie raspbian/stretch raspbian/buster raspbian/bullseye linuxmint/tina linuxmint/tricia linuxmint/ulyana linuxmint/ulyssa linuxmint/tessa linuxmint/uma linuxmint/una linuxmint/vanessa debian/wheezy debian/jessie debian/stretch debian/buster debian/bullseye debian/bookworm debian/trixie ubuntu/trusty ubuntu/utopic ubuntu/vivid ubuntu/wily ubuntu/xenial ubuntu/yakkety ubuntu/zesty ubuntu/artful ubuntu/bionic ubuntu/disco ubuntu/focal ubuntu/jammy ubuntu/kinetic"

echo "PACKAGECLOUD_REPO=${PACKAGECLOUD_REPO}"
echo "DEB_PACKAGE__NAME=${DEB_PACKAGE_NAME}"
echo "RPM_PACKAGE_NAME=${RPM_PACKAGE_NAME}"

UPLOAD_PATH="${PACKAGECLOUD_USERNAME}/${PACKAGECLOUD_REPO}"

# If a DEB package is specified, it loops through all the DEB distors and uploads them to packagecloud
if [ -n "${DEB_PACKAGE_NAME}" ]; then
	for DST in ${DEB_DSTS[@]}; do
		echo "Uploading ${DEB_PACKAGE_NAME} to $DST"
		package_cloud push ${UPLOAD_PATH}/${DST} ${DEB_PACKAGE_NAME} --skip-errors
	done
fi

# If a RPM package is specified, it loops through all the RPM distros and uploads them to packagecloud
if [ -n "${RPM_PACKAGE_NAME}" ]; then
	for DST in ${RPM_DSTS[@]}; do
		echo "Uploading ${RPM_PACKAGE_NAME} to $DST"
		package_cloud push ${UPLOAD_PATH}/${DST} ${RPM_PACKAGE_NAME} --skip-errors
	done
fi

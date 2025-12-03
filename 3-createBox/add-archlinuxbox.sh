#!/bin/sh

source ../version.sh

vagrant box remove archlinuxbox

// vagrant box add archlinuxbox.box --name archlinuxbox
vagrant box add BoxCatalogMetadata.json --box-version $Version
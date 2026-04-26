#!/bin/sh

source ../variables.sh

vboxmanage storageattach $VM --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium emptydrive

ArchBoxName="archlinuxbox-$Version.box"
vagrant package --base archlinuxbox --output $ArchBoxName
echo ""
echo ""
echo "=== Put sha1 to BoxCatalogMetadata.json ==="
shaSum=$(sha1sum $ArchBoxName | awk '{print $1}')
echo "$shaSum"

CatalogMetadataJson="
{
  \"name\": \"archlinuxbox\",
  \"description\": \"This box contains Archlinux.\",
  \"versions\": [
    {
      \"version\": \"$Version\",
      \"providers\": [
        {
          \"name\": \"virtualbox\",
          \"url\": \"./archlinuxbox-$Version.box\",
          \"checksum_type\": \"sha1\",
          \"checksum\": \"$shaSum\",
          \"architecture\": \"amd64\",
          \"default_architecture\": true
        }
      ]
    }
  ]
}"

echo "$CatalogMetadataJson" > BoxCatalogMetadata.json
#!/bin/sh

source ../variables.sh

vboxmanage storageattach $VM --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium emptydrive

ArchBoxName="$VM-$Version.box"
vagrant package --base $VM --output $ArchBoxName
echo ""
echo ""
echo "=== Put sha1 to BoxCatalogMetadata.json ==="
shaSum=$(sha1sum $ArchBoxName | awk '{print $1}')
echo "$shaSum"

CatalogMetadataJson="
{
  \"name\": \"$VM\",
  \"description\": \"This box contains Archlinux.\",
  \"versions\": [
    {
      \"version\": \"$Version\",
      \"providers\": [
        {
          \"name\": \"virtualbox\",
          \"url\": \"./$VM-$Version.box\",
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
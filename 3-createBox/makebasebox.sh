#!/bin/sh

source ../version.sh

ArchBoxName="archlinuxbox-$Version.box"
vagrant package --base archlinuxbox --output $ArchBoxName
echo ""
echo ""
echo "=== Put sha1 to BoxCatalogMetadata.json ==="
shaSum=$(sha1sum $ArchBoxName | awk '{print $1}')
echo ""

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
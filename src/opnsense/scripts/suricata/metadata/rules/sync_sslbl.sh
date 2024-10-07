#!/bin/sh
remote_file_url="https://raw.githubusercontent.com/HiepF5/test_rules/refs/heads/master/sslbl.xml"
local_file="/usr/local/opnsense/scripts/suricata/metadata/rules/sslbl.xml"
temp_file="/tmp/sslbl_new.xml"
curl -s -o "$temp_file" "$remote_file_url"
if ! cmp -s "$local_file" "$temp_file"; then
    mv "$temp_file" "$local_file"
    echo "$(date): Tệp sslbl.xml đã được cập nhật."
else
    echo "$(date): Tệp sslbl.xml không thay đổi."
    rm "$temp_file"
fi

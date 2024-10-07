#!/bin/sh
remote_files=(
    "https://raw.githubusercontent.com/HiepF5/test_rules/refs/heads/master/sslbl.xml"
    "https://raw.githubusercontent.com/HiepF5/test_rules/refs/heads/master/et-open.xml"
    "https://raw.githubusercontent.com/HiepF5/test_rules/refs/heads/master/opnsense.xml"
)
local_files=(
    "/usr/local/opnsense/scripts/suricata/metadata/rules/sslbl.xml"
    "/usr/local/opnsense/scripts/suricata/metadata/rules/et-open.xml"
    "/usr/local/opnsense/scripts/suricata/metadata/rules/opnsense.xml"
)
for i in "${!remote_files[@]}"; do
    remote_file_url="${remote_files[i]}"
    local_file="${local_files[i]}"
    temp_file="/tmp/$(basename "$local_file")"
    curl -s -o "$temp_file" "$remote_file_url"
    if ! cmp -s "$local_file" "$temp_file"; then
        mv "$temp_file" "$local_file"
        echo "$(date): Tệp $(basename "$local_file") đã được cập nhật."
    else
        echo "$(date): Tệp $(basename "$local_file") không thay đổi."
        rm "$temp_file"
    fi
done
croncmd="/usr/local/opnsense/scripts/suricata/update_all_rules.sh"
cronjob="0 2 * * * $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -
echo "$(date): Đã thêm cronjob để cập nhật rules hàng ngày vào lúc 2 giờ sáng."

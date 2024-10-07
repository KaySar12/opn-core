
```cmd
crontab -e

0 2 * * * (/usr/local/opnsense/scripts/suricata/metadata/rules/sync_sslbl.sh) >> /usr/local/opnsense/scripts/suricata/metadata/rules/sync_sslbl.log 2>&1

sudo service cron restart
```

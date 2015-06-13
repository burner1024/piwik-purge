#!/bin/bash

set -xeu -o pipefail

db=$1
id=$2

tables="$(mysql -Bn piwik -e 'show tables;' | grep -v 'Tables_in')"
tables_archive="$(echo "$tables" | grep piwik_archive)"
tables_log="$(echo "$tables" | grep piwik_log)"

for tbl in $tables_archive; do
  mysql $db -e "DELETE FROM $tbl WHERE idsite = $id;"
done

mysql $db -e "DELETE FROM piwik_log_visit WHERE idsite = $id;"
mysql $db -e "DELETE FROM piwik_log_link_visit_action WHERE idsite = $id;"
mysql $db -e "DELETE FROM piwik_log_conversion WHERE idsite = $id;"
mysql $db -e "DELETE FROM piwik_log_conversion_item WHERE idsite = $id;"

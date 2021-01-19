#!/bin/bash

set -e
. "${PWD}"/.env

message() {
  echo ""
  echo -e "$1"
  seq ${#1} | awk '{printf "-"}'
  echo ""
}

setup() {
  message "docker exec -it $1 bin/magento config:set cms/wysiwyg/enabled disabled"
  docker exec -it "$1" bin/magento config:set cms/wysiwyg/enabled disabled

  message "docker exec -it $1 bin/magento config:set admin/security/admin_account_sharing 1"
  docker exec -it "$1" bin/magento config:set admin/security/admin_account_sharing 1

  message "docker exec -it $1 bin/magento config:set admin/security/use_form_key 0;"
  docker exec -it "$1" bin/magento config:set admin/security/use_form_key 0

  message "docker exec -it $1 bin/magento cache:clean;"
  docker exec -it "$1" bin/magento cache:clean
}

start() {
  docker-compose up -d
}

start
setup "${NAMESPACE}"_php

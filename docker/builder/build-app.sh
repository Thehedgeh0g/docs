#!/usr/bin/env bash

set -o errexit

cp ./hugo_pages_editor/.env.test .env

while getopts "m:" opt; do
  case ${opt} in
  m ) mode="$OPTARG" ;;
  esac
done

if [[ "$mode" != "fast" ]]; then
    cd hugo_pages_editor
    composer install
    php bin/phpunit
fi


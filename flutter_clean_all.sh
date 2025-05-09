#!/bin/sh
set -e

echo "Limpando módulo $PWD..."
flutter clean
flutter pub get
#flutter packages upgrade --major-versions
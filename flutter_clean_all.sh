
echo "limpando ipbc mobile..."
cd apps/ipbc_mobile
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando ipbc web..."
cd ../../apps/ipbc_web
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando core module..."
cd ../../packages/core_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get


echo "limpando service module..."
cd ../../packages/service_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando home module..."
cd ../../packages/home_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando auth module..."
cd ../../packages/auth_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando events module..."
cd ../../packages/events_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando lyric module..."
cd ../../packages/lyric_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get

echo "limpando offers module..."
cd ../../packages/offers_module
flutter packages upgrade --major-versions
flutter clean
flutter pub get
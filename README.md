# insite

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build commands

For Vision Link - flutter run --flavor visionlink -t lib/main_visionlink.dart
For India Stack - flutter run --flavor indiastack -t lib/main_indiastack.dart
For WorksIQ - flutter run --flavor worksiq -t lib/main_worksiq.dart
For Cummins- flutter run --flavor cummins -t lib/main_cummins.dart

For Vision Link Release - flutter build apk --flavor visionlink -t lib/main_visionlink.dart
For India Stack Release - flutter build apk --flavor indiastack -t lib/main_indiastack.dart
For WorksIQ Release - flutter build apk --flavor worksiq -t lib/main_worksiq.dart
For Cummins Release- flutter build apk --flavor cummins -t lib/main_cummins.dart

IOS:
For Vision Link Release - flutter build ios --flavor visionlink -t lib/main_visionlink.dart
For India Stack Release - flutter build ios --flavor indiastack -t lib/main_indiastack.dart
For WorksIQ Release - flutter build ios --flavor worksiq -t lib/main_worksiq.dart
For Cummins Release- flutter build ios --flavor cummins -t lib/main_cummins.dart


## Build app_bundle commands

For Vision Link app_bundle - flutter build appbundle --flavor visionlink -t lib/main_visionlink.dart
For India Stack app_bundle - flutter build appbundle --flavor indiastack -t lib/main_indiastack.dart
For WorksIQ app_bundle - flutter build appbundle --flavor worksiq -t lib/main_worksiq.dart
For Cummins app_bundle- flutter build appbundle --flavor cummins -t lib/main_cummins.dart

For Vision Link Split Release:
flutter build apk --flavor visionlink -t lib/main_visionlink.dart --target-platform android-arm,android-arm64,android-x64 --split-per-abi
        or
flutter build apk --flavor visionlink --target-platform android-arm,android-arm64,android-x64 --split-per-abi

For India Stack Split Release:
flutter build apk --flavor indiastack -t lib/main_indiastack.dart 
--target-platform android-arm,android-arm64,android-x64 --split-per-abi 
        or
flutter build apk --flavor indiastack --target-platform android-arm,android-arm64,android-x64 --split-per-abi

## Build commands when using FVM

For Vision Link - fvm flutter run --flavor visionlink -t lib/main_visionlink.dart
For India Stack - fvm flutter run --flavor indiastack -t lib/main_indiastack.dart
For WorksIq - fvm flutter run --flavor worksiq -t lib/main_worksiq.dart
for Cummins-fvm flutter run --flavor cummins -t lib/main_cummins.dart

For Vision Link Release - fvm flutter build apk --flavor visionlink -t lib/main_visionlink.dart
For India Stack Release - fvm flutter build apk --flavor indiastack -t lib/main_indiastack.dart
For WorksIq Release - fvm flutter build apk --flavor worksiq -t lib/main_worksiq.dart
For Cummins Release-fvm flutter build apk --flavor cummins -t lib/main_cummins.dart

IOS:
For Vision Link Release - fvm flutter build ios --flavor visionlink -t lib/main_visionlink.dart
For India Stack Release - fvm flutter build ios --flavor indiastack -t lib/main_indiastack.dart
For WorksIq Release - fvm flutter build ios --flavor worksiq -t lib/main_worksiq.dart
For Cummins Release-fvm flutter build apk --flavor cummins -t lib/main_cummins.dart

For Vision Link Split Release:
fvm flutter build apk --flavor visionlink -t lib/main_visionlink.dart --target-platform android-arm,android-arm64,android-x64 --split-per-abi
        or
fvm flutter build apk --flavor visionlink --target-platform android-arm,android-arm64,android-x64 --split-per-abi

For India Stack Split Release:
fvm flutter build apk --flavor indiastack -t lib/main_indiastack.dart 
--target-platform android-arm,android-arm64,android-x64 --split-per-abi 
        or
fvm flutter build apk --flavor indiastack --target-platform android-arm,android-arm64,android-x64 --split-per-abi

## Adding app signed details

- create key.properties in android folder

- get keystore.jks file,store password, key password, aliasname from your team and follow third step

- add below lines in key.properties file created in the first step

storePassword=<storepassword>
keyPassword=<keypassword>
keyAlias=<alias name>
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>

for more info #see https://flutter.dev/docs/deployment/android#reference-the-keystore-from-the-app

for using azure:
Add --mirror flag after git command and want to mention git clone repository url


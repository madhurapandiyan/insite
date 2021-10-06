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

For Vision Link Release - flutter build apk --flavor visionlink -t lib/main_visionlink.dart
For India Stack Release - flutter build apk --flavor indiastack -t lib/main_indiastack.dart

IOS:
For Vision Link Release - flutter build ios --flavor visionlink -t lib/main_visionlink.dart
For India Stack Release - flutter build ios --flavor indiastack -t lib/main_indiastack.dart

For Vision Link Split Release:
flutter build apk --flavor visionlink -t lib/main_visionlink.dart --target-platform android-arm,android-arm64,android-x64 --split-per-abi
        or
flutter build apk --flavor visionlink --target-platform android-arm,android-arm64,android-x64 --split-per-abi

For India Stack Split Release:
flutter build apk --flavor indiastack -t lib/main_indiastack.dart 
--target-platform android-arm,android-arm64,android-x64 --split-per-abi 
        or
flutter build apk --flavor indiastack --target-platform android-arm,android-arm64,android-x64 --split-per-abi
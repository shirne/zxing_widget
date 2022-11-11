ZXing Widget(Dart)


A Barcode Generator Widget that can be embedded inside flutter. It uses zxing-dart for all platforms.

## Features

- ✅ QRCode
- ✅ PDF417 code
- ✅ DataMatrix code
- ✅ AZTec code
- ✅ OneDemension code

## Getting started

flutter pub add zxing_widget

## Usage

See `/example` folder.

Scan from camera
```dart
QRCodeWidget(
    'data to be encoded',
),
```

## Additional information

This package depends on [zxing_lib](https://pub.flutter-io.cn/packages/zxing_lib) witch is a pure dart port of ZXing.

# ZXing Widget(Dart)
[![pub package](https://img.shields.io/pub/v/zxing_widget.svg)](https://pub.dartlang.org/packages/zxing_widget)

A Barcode Generator Widget that can be embedded inside flutter. It uses zxing-dart for all platforms.

| | |
|:---:|:---:|
|ZXing Dart|[![pub package](https://img.shields.io/pub/v/zxing_lib.svg)](https://pub.dartlang.org/packages/zxing_lib)|
|ZXing Widget|[![pub package](https://img.shields.io/pub/v/zxing_widget.svg)](https://pub.dartlang.org/packages/zxing_widget)|
|ZXing Scanner|[![pub package](https://img.shields.io/pub/v/zxing_scanner.svg)](https://pub.dartlang.org/packages/zxing_scanner)|

## Features

- ✅ QRCode
- ✅ PDF417 code
- ✅ DataMatrix code
- ✅ AZTec code
- ✅ OneDemension code
- ✅ Paint callback
- ✅ Customize color
- ✅ to image

## Preview

<img src="preview/codes.png" width="300" alt="Code Generator Preview"/>

## Getting started

flutter pub add zxing_widget

## Usage

See `/example` folder.

Render a qrcode
```dart
BarcodeWidget(
    QrcodePainter(
        'qrcode data',
        errorCorrectionLevel: ErrorCorrectionLevel.H,
        foregroundColor: Colors.blue,
    ),
    size: const Size(200, 200),
),
```

Generate an image
```dart
import 'dart:ui' as ui;

final ui.Image image = QrcodePainter(
        'qrcode data',
        errorCorrectionLevel: ErrorCorrectionLevel.H,
        foregroundColor: Colors.blue,
    ).toImage(const Size(200, 200));

// binary png data
final binData = await image.toByteData(format: ui.ImageByteFormat.png);
```

## Additional information

This package depends on [zxing_lib](https://pub.dartlang.org/packages/zxing_lib) witch is a pure dart port of ZXing.

import 'dart:convert';

import 'package:zxing_lib/pdf417.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

class PDF417Painter extends BarcodePainter {
  PDF417Painter(
    super.data, {
    this.compaction,
    this.errorCorrectionLevel,
    this.encoding,
    this.autoEci,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });
  final Compaction? compaction;

  // 0-8
  final int? errorCorrectionLevel;
  final Encoding? encoding;
  final bool? autoEci;

  @override
  BitMatrix encodeData(data) {
    return PDF417Writer().encode(data, BarcodeFormat.PDF_417, 1, 1, {
      if (compaction != null) EncodeHintType.PDF417_COMPACTION: compaction!,
      if (errorCorrectionLevel != null)
        EncodeHintType.ERROR_CORRECTION: errorCorrectionLevel!,
      if (encoding != null) EncodeHintType.CHARACTER_SET: encoding!,
      if (autoEci != null) EncodeHintType.PDF417_AUTO_ECI: autoEci!,
      EncodeHintType.MARGIN: 0,
    });
  }
}

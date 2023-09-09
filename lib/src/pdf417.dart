import 'dart:convert';

import 'package:zxing_lib/pdf417.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

/// PDF417 code painter
class PDF417Painter extends BarcodePainter {
  /// constructor
  const PDF417Painter(
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

  /// see [EncodeHintType.pdf417Compaction]
  final Compaction? compaction;

  /// 0-8. see [EncodeHintType.errorCorrection]
  final int? errorCorrectionLevel;

  /// data encoding
  final Encoding? encoding;

  /// see [EncodeHintType.pdf417AutoEci]
  final bool? autoEci;

  @override
  BitMatrix encodeData(data) {
    return PDF417Writer().encode(
      data,
      BarcodeFormat.pdf417,
      1,
      1,
      EncodeHint(
        pdf417Compaction: compaction,
        errorCorrection: errorCorrectionLevel,
        characterSet: encoding?.name,
        pdf417AutoEci: autoEci ?? false,
        margin: 0,
      ),
    );
  }
}

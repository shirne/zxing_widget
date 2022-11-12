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

  /// see [EncodeHintType.PDF417_COMPACTION]
  final Compaction? compaction;

  /// 0-8. see [EncodeHintType.ERROR_CORRECTION]
  final int? errorCorrectionLevel;

  /// data encoding
  final Encoding? encoding;

  /// see [EncodeHintType.PDF417_AUTO_ECI]
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

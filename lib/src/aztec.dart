import 'dart:convert';

import 'package:zxing_lib/aztec.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

/// AZTec code painter.
class AztecPainter extends BarcodePainter {
  /// constructor
  const AztecPainter(
    super.data, {
    this.errorPercent,
    this.encoding,
    this.aztecLayers,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });

  /// error percent(0-100)
  final int? errorPercent;

  /// data encoding
  final Encoding? encoding;

  /// aztec layer. see [EncodeHintType.AZTEC_LAYERS]
  final int? aztecLayers;

  @override
  BitMatrix encodeData(data) {
    return AztecWriter().encode(data, BarcodeFormat.AZTEC, 1, 1, {
      if (errorPercent != null) EncodeHintType.ERROR_CORRECTION: errorPercent!,
      if (encoding != null) EncodeHintType.CHARACTER_SET: encoding!,
      if (aztecLayers != null) EncodeHintType.AZTEC_LAYERS: aztecLayers!,
      EncodeHintType.MARGIN: 0,
    });
  }
}

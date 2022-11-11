import 'dart:convert';

import 'package:zxing_lib/aztec.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

class AztecPainter extends BarcodePainter {
  AztecPainter(
    super.data, {
    this.errorPercent,
    this.encoding,
    this.aztecLayers,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });
  final int? errorPercent;
  final Encoding? encoding;
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

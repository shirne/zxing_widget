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

  /// aztec layer. see [EncodeHintType.aztecLayers]
  final int? aztecLayers;

  @override
  BitMatrix encodeData(data) {
    return AztecWriter().encode(
      data,
      BarcodeFormat.aztec,
      1,
      1,
      EncodeHint(
        errorCorrection: errorPercent,
        characterSet: encoding?.name,
        aztecLayers: aztecLayers,
        margin: 0,
      ),
    );
  }
}

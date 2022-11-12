import 'package:zxing_lib/qrcode.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

/// qrcode painter
class QrcodePainter extends BarcodePainter {
  /// constructor
  const QrcodePainter(
    super.data, {
    this.errorCorrectionLevel,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });

  /// Error Correction Level
  final ErrorCorrectionLevel? errorCorrectionLevel;

  @override
  BitMatrix encodeData(data) {
    return QRCodeWriter().encode(data, BarcodeFormat.QR_CODE, 1, 1, {
      if (errorCorrectionLevel != null)
        EncodeHintType.ERROR_CORRECTION: errorCorrectionLevel!.index,
      EncodeHintType.MARGIN: 0,
    });
  }
}

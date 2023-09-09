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
    return QRCodeWriter().encode(
      data,
      BarcodeFormat.qrCode,
      1,
      1,
      EncodeHint(
        errorCorrectionLevel: errorCorrectionLevel,
        margin: 0,
      ),
    );
  }
}

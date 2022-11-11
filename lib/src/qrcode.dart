import 'package:zxing_lib/qrcode.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'painter.dart';

class QrcodePainter extends BarcodePainter {
  QrcodePainter(
    super.data, {
    this.errorCorrectionLevel,
  });
  final ErrorCorrectionLevel? errorCorrectionLevel;
  @override
  BitMatrix encodeData(data) {
    return QRCodeWriter().encode(data, BarcodeFormat.QR_CODE, 1, 1, {
      if (errorCorrectionLevel != null)
        EncodeHintType.ERROR_CORRECTION: errorCorrectionLevel!.index,
    });
  }
}

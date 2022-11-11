import 'package:flutter/painting.dart';
import 'package:zxing_lib/oned.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

class OnedPainter extends BarcodePainter {
  const OnedPainter(
    super.data,
    this.writer, {
    this.format,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });

  final OneDimensionalCodeWriter writer;
  final BarcodeFormat? format;

  @override
  BitMatrix encodeData(data) {
    return writer.encode(
      data,
      format ?? writer.supportedWriteFormats!.first,
      1,
      1,
      {
        EncodeHintType.MARGIN: 0,
      },
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final matrix = encodeData(data);
    final tmpWidth = size.width - padding * 2;
    double pixelSize = (tmpWidth ~/ matrix.width).toDouble();
    if (pixelSize < 2) pixelSize = 2;
    final adjust = (tmpWidth - matrix.width * pixelSize) / 2;

    final rPadding = padding + adjust;
    final rect = Rect.fromPoints(
      Offset(rPadding, rPadding),
      Offset(size.width - rPadding, size.height - rPadding),
    );

    canvas.drawRect(
      Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
      Paint()..color = backgroundColor,
    );

    final paint = Paint()..color = foregroundColor;
    for (int x = 0; x < matrix.width; x++) {
      if (matrix.get(x, 0)) {
        canvas.drawRect(
          Rect.fromLTWH(
            rect.left + x * pixelSize,
            rect.top,
            pixelSize,
            size.height - rPadding * 2,
          ),
          paint,
        );
      }
    }
    afterPaint?.call(canvas, size);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:zxing_lib/common.dart';

import 'constants.dart';

class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget(
    this.painter, {
    this.size = const Size(100, 100),
    super.key,
  });

  final Size size;
  final BarcodePainter painter;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: painter,
    );
  }
}

abstract class BarcodePainter extends CustomPainter {
  BarcodePainter(
    this.data, {
    this.padding = 5,
    this.backgroundColor = zDefaultBackgroundColor,
    this.foregroundColor = zDefaultForegroundColor,
  });

  final String data;
  final double padding;
  final Color backgroundColor;
  final Color foregroundColor;

  BitMatrix encodeData(data);

  @override
  bool shouldRepaint(BarcodePainter oldDelegate) =>
      data != oldDelegate.data || padding != oldDelegate.padding;

  @override
  void paint(Canvas canvas, Size size) {
    final shortest = size.shortestSide;

    final tmpWidth = shortest - padding * 2;
    final matrix = encodeData(data);

    double pixelSize = (tmpWidth ~/ matrix.width).toDouble();
    if (pixelSize < 2) pixelSize = 2;
    final adjust = tmpWidth - matrix.width * pixelSize;

    final wOffset = (size.width - shortest + adjust) / 2;
    final hOffset = (size.height - shortest + adjust) / 2;
    final rect = Rect.fromPoints(
      Offset(padding + wOffset, padding + hOffset),
      Offset(size.width - padding - wOffset, size.height - padding - hOffset),
    );

    canvas.drawRect(
      Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
      Paint()..color = backgroundColor,
    );

    final paint = Paint()..color = foregroundColor;
    for (int x = 0; x < matrix.width; x++) {
      for (int y = 0; y < matrix.height; y++) {
        if (matrix.get(x, y)) {
          canvas.drawRect(
            Rect.fromLTWH(
              rect.left + x * pixelSize,
              rect.top + y * pixelSize,
              pixelSize,
              pixelSize,
            ),
            paint,
          );
        }
      }
    }
  }
}

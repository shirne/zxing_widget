import 'dart:math' as math;

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
  const BarcodePainter(
    this.data, {
    this.padding = 5,
    this.backgroundColor = zDefaultBackgroundColor,
    this.foregroundColor = zDefaultForegroundColor,
    this.afterPaint,
  });

  final String data;
  final double padding;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function(Canvas, Size)? afterPaint;

  BitMatrix encodeData(data);

  @override
  bool shouldRepaint(BarcodePainter oldDelegate) =>
      data != oldDelegate.data ||
      padding != oldDelegate.padding ||
      backgroundColor != oldDelegate.backgroundColor ||
      foregroundColor != oldDelegate.foregroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final matrix = encodeData(data);

    final pixelWith = ((size.width - padding * 2) ~/ matrix.width).toDouble();
    final pixelHeight =
        ((size.height - padding * 2) ~/ matrix.height).toDouble();

    double pixelSize = math.min(pixelWith, pixelHeight);

    if (pixelSize < 2) pixelSize = 2;

    final wOffset = (size.width - matrix.width * pixelSize) / 2;
    final hOffset = (size.height - matrix.height * pixelSize) / 2;
    final rect = Rect.fromPoints(
      Offset(wOffset, hOffset),
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
    afterPaint?.call(canvas, size);
  }
}

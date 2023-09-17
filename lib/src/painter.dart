import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:zxing_lib/common.dart';

import 'constants.dart';

/// A Widget to show code painted by [Painter]
class BarcodeWidget extends StatelessWidget {
  /// constructor
  const BarcodeWidget(
    this.painter, {
    this.size = const Size(100, 100),
    super.key,
    this.child,
  });

  /// widget size
  final Size size;

  /// barcode painter
  final BarcodePainter painter;

  /// child above [CustomPaint]
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: painter,
      child: child,
    );
  }
}

/// abstract painter. paint a [BitMatrix] data to canvas
abstract class BarcodePainter extends CustomPainter {
  /// constructor
  const BarcodePainter(
    this.data, {
    this.padding = 5,
    this.backgroundColor = zDefaultBackgroundColor,
    this.foregroundColor = zDefaultForegroundColor,
    this.afterPaint,
  });

  /// data to be encode and paint
  final String data;

  /// space around barcode
  final double padding;

  /// background color
  final Color backgroundColor;

  /// foreground color
  final Color foregroundColor;

  /// after paint callback. you can paint yout
  final Function(Canvas, Size)? afterPaint;

  /// encode data to a BitMatrix
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

    final pixelWith = (size.width - padding * 2) / matrix.width;
    final pixelHeight = (size.height - padding * 2) / matrix.height;

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
    final row = BitArray(matrix.width);
    int x = 0, x2 = 0;
    for (int y = 0; y < matrix.height; y++) {
      matrix.getRow(y, row);
      x = row.getNextSet(0);
      x2 = row.getNextUnset(x);
      while (x < row.size) {
        canvas.drawRect(
          Rect.fromLTWH(
            rect.left + x * pixelSize,
            rect.top + y * pixelSize - 0.1,
            pixelSize * (x2 - x),
            pixelSize + 0.1,
          ),
          paint,
        );
        x = row.getNextSet(x2);
        x2 = row.getNextUnset(x);
      }
    }
    afterPaint?.call(canvas, size);
  }

  /// draw barcode to an image
  /// you can call image.toByteData to generate binary data
  Future<ui.Image> toImage(Size size) async {
    final pr = ui.PictureRecorder();
    final canvas = Canvas(pr);
    paint(canvas, size);
    canvas.save();
    final picture = pr.endRecording();
    return await picture.toImage(size.width.toInt(), size.height.toInt());
  }
}

import 'dart:convert';

import 'package:zxing_lib/datamatrix.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

/// DataMatrix code painter.
class DataMatrixPainter extends BarcodePainter {
  /// constructor
  const DataMatrixPainter(
    super.data, {
    this.symbolShapeHint,
    this.compact,
    this.encoding,
    this.gs1Format,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });

  /// see [EncodeHintType.dataMatrixShape]
  final SymbolShapeHint? symbolShapeHint;

  /// see [EncodeHintType.dataMatrixCompact]
  final bool? compact;

  /// data encoding
  final Encoding? encoding;

  /// see [EncodeHintType.gs1Format]
  final bool? gs1Format;

  @override
  BitMatrix encodeData(data) {
    return DataMatrixWriter().encode(
      data,
      BarcodeFormat.dataMatrix,
      1,
      1,
      EncodeHint(
        dataMatrixShape: symbolShapeHint,
        dataMatrixCompact: compact ?? false,
        gs1Format: gs1Format ?? false,
        margin: 0,
      ),
    );
  }
}

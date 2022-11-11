import 'dart:convert';

import 'package:zxing_lib/datamatrix.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/zxing.dart';

import 'constants.dart';
import 'painter.dart';

class DataMatrixPainter extends BarcodePainter {
  const DataMatrixPainter(
    super.data, {
    this.symbolShapeHint,
    this.compact,
    this.encoding,
    this.gsiFormat,
    super.padding = 5,
    super.backgroundColor = zDefaultBackgroundColor,
    super.foregroundColor = zDefaultForegroundColor,
    super.afterPaint,
  });
  final SymbolShapeHint? symbolShapeHint;
  final bool? compact;
  final Encoding? encoding;
  final bool? gsiFormat;
  @override
  BitMatrix encodeData(data) {
    return DataMatrixWriter().encode(data, BarcodeFormat.DATA_MATRIX, 1, 1, {
      if (symbolShapeHint != null)
        EncodeHintType.DATA_MATRIX_SHAPE: symbolShapeHint!,
      if (compact != null) EncodeHintType.DATA_MATRIX_COMPACT: compact!,
      if (gsiFormat != null) EncodeHintType.GS1_FORMAT: gsiFormat!,
      EncodeHintType.MARGIN: 0,
    });
  }
}

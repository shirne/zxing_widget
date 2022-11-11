import 'package:flutter/material.dart';
import 'package:zxing_widget/zxing_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZXing Widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ZXing Widget Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: BarcodeWidget(
                QrcodePainter('qrcode data'),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: BarcodeWidget(
                QrcodePainter(
                  'qrcode data',
                  errorCorrectionLevel: ErrorCorrectionLevel.H,
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: BarcodeWidget(
                PDF417Painter('pdf417 data'),
                size: Size(300, 100),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: BarcodeWidget(
                DataMatrixPainter('DataMatrix data'),
                size: Size(300, 200),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: BarcodeWidget(
                AztecPainter('AZTec data'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: BarcodeWidget(
                OnedPainter('123456', Code93Writer()),
                size: const Size(300, 100),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: BarcodeWidget(
                OnedPainter('987654321', Code128Writer()),
                size: const Size(350, 100),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

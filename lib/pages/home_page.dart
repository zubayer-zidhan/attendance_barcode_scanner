import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanBarcodeResult = "";

  // Scan Barcode Stream
  Future<void> scanBarcodeStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    )!
        .listen((barcode) => debugPrint(barcode));
  }

  // Scan Barcode
  Future<void> scanBarcodeNormal() async {
    String barcodeScanData;
    try {
      barcodeScanData = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );

      debugPrint(barcodeScanData);
    } on PlatformException {
      barcodeScanData = "Failed to get platform version.";
    }

    if (!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: scanBarcodeNormal,
            child: const Text("Scan Now"),
          ),
          ElevatedButton(
            onPressed: scanBarcodeStream,
            child: const Text("Start scanning barcode stream"),
          ),
          Text(
            "Scan result: $_scanBarcodeResult\n",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.deepPurple,
              decorationThickness: 0,
            ),
          ),
        ],
      ),
    );
  }
}

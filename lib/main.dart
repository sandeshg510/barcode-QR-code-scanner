import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QR Code Scanner And Generator',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qrResult = "Scanned data will appear here";

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrResult = qrCode.toString();
      });
    } on PlatformException {
      qrResult = "Failed to read QR code";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                'Barcode & QR code scanner',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              const Expanded(child: SizedBox()),
              Text(
                qrResult,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 18),
              ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () {
                  scanQR();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                        Colors.purple,
                        Colors.blue,
                        Colors.green,
                      ])),
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 56,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28)),
                        color: Colors.black),
                    alignment: Alignment.center,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.green,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Tap to scan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors
                              .white, // Set this to any color; it will be overridden by the gradient.
                        ),
                      ),
                    ),
                    // const Text('Tap to scan',style: TextStyle(color: Colors.yellow,fontSize: 18,fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

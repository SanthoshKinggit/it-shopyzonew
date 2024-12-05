// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with TickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );
  final ImagePicker picker = ImagePicker();

  bool isStarted = true;
  String? scannedCode;
  late AnimationController _scanningLineController;
  late Animation<double> _scanningLineAnimation;

  @override
  void initState() {
    super.initState();

    // Scanning line animation controller
    _scanningLineController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    _scanningLineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanningLineController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final inputImage = InputImage.fromFilePath(image.path);
        final barcodeScanner = GoogleMlKitBarcodeScannerWrapper();

        final barcodes = await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final firstBarcode = barcodes.first;
          setState(() {
            scannedCode = firstBarcode.rawValue;
          });
        }
      }
    } catch (e) {
      // Error handling here
    }
  }

  @override
  void dispose() {
    _scanningLineController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Scan and Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Please point the camera at the QR Code',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        isStarted
                            ? MobileScanner(
                                controller: cameraController,
                                onDetect: (capture) {
                                  final barcodes = capture.barcodes;
                                  for (final barcode in barcodes) {
                                    setState(() {
                                      scannedCode = barcode.rawValue;
                                    });
                                  }
                                },
                              )
                            : const Center(
                                child: Text(
                                  'Scanner Paused',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                        // Sliding green line
                        AnimatedBuilder(
                          animation: _scanningLineAnimation,
                          builder: (context, child) {
                            return Positioned(
                              top: MediaQuery.of(context).size.height *
                                  0.6 *
                                  _scanningLineAnimation.value,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        icon: const Icon(Icons.image, color: Colors.white),
                        onPressed: _pickImage,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: isStarted ? Colors.red : Colors.green,
                      child: IconButton(
                        icon: Icon(
                          isStarted ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isStarted = !isStarted;
                            if (isStarted) {
                              cameraController.start();
                            } else {
                              cameraController.stop();
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        icon: const Icon(Icons.flash_on, color: Colors.white),
                        onPressed: () => cameraController.toggleTorch(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GoogleMlKitBarcodeScannerWrapper {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();

  Future processImage(InputImage inputImage) async {
    try {
      return await _barcodeScanner.processImage(inputImage);
    } catch (e) {
      return [];
    } finally {
      _barcodeScanner.close();
    }
  }
}

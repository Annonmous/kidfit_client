import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  String _scannedResult = "Scan a QR code";
  final themeController = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 300.sp,
              width: 300.sp,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: QRView(
                  overlay: QrScannerOverlayShape(
                    borderRadius: 20,
                    borderLength: 30.sp,
                    borderWidth: 6.sp,
                    borderColor: themeController.colorPrimary,
                  ),
                  key: _qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Text(
              _scannedResult,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
      floatingActionButton: SpringWidget(
        onTap: () {
          // Call a function to manually trigger QR code scanning
          if (_qrViewController != null) {
            _qrViewController!.pauseCamera();

          }
        },
        child: CircleAvatar(
          child: CircleAvatar(radius: 50, child: Icon(Icons.camera_alt)),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _qrViewController = controller;
    });

    // controller.scannedDataStream.listen((scannedData) {
    //   setState(() {
    //     _scannedResult = scannedData as String;
    //   });
    // });
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }
}

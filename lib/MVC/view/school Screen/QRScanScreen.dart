import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:barcode_scan/barcode_scan.dart';

class QRCodeScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  RxString _scannedResult = "".obs;
  RxBool _cameraPause = false.obs;
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
          // Obx(
          //   () => Container(
          //     padding: EdgeInsets.all(10.0),
          //     color: Colors.white,
          //     child: Text(
          //       _scannedResult.value,
          //       textAlign: TextAlign.center,
          //       style: TextStyle(fontSize: 10.sp),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => _cameraPause.value
                ? SpringWidget(
                    onTap: () {
                      _qrViewController!.resumeCamera();
                      _cameraPause.value = false;
                      _scannedResult.value = '';
                    },
                    child: CircleAvatar(
                      backgroundColor: themeController.colorPrimary,
                      radius: 30.sp,
                      child: Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Text(
                      'Scan a QR code',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
          )
        ],
      ),
      // floatingActionButton: SpringWidget(
      //   onTap: () {
      //     // Call a function to manually trigger QR code scanning
      //     if (_qrViewController != null) {
      //       _qrViewController!.pauseCamera();
      //     }
      //   },
      //   child: CircleAvatar(
      //     child: CircleAvatar(radius: 50, child: Icon(Icons.camera_alt)),
      //   ),
      // ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    try {
      setState(() {
        _qrViewController = controller;
      });

      controller.scannedDataStream.listen((scannedData) {
        _qrViewController!.pauseCamera();
        _cameraPause.value = true;
        _scannedResult.value = scannedData.code!;

        List<String> keyValuePairs = _scannedResult.value
            .replaceAll('{', '')
            .replaceAll('}', '')
            .split(', ');
        Map<String, dynamic> data = {};
        keyValuePairs.forEach((pair) {
          List<String> parts = pair.split(': ');
          data[parts[0]] = parts[1];
        });
        String id = data['id'];
        String parentId = data['parentId'];
        String schoolId = data['schoolId'];
        print('kid_id: $id');
        print('parentId: $parentId');
        print('schoolId: $schoolId');
      });
    } catch (e) {
      print('error while scanning: ${e}');
    }
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/qr/controller/qr_controller.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class QrScan extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String? result;
  QRViewController? controller;
  late QrController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void initState() {
    qrController = QrController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, title: "Qr Code"),
      body: Center(child: _buildQrView(context)),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 204.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: primaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async{
      if (result == null || result!.isEmpty) {
        setState(() {
          result = scanData.code;
          controller.pauseCamera();
        });
        await qrController.joinEvent(result!);
        if(mounted){
          setState(() {
            result = null;
            controller.resumeCamera();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

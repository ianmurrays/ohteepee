import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';

import '../storage/database.dart';
import '../storage/password_model.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final _qrKey = GlobalKey();
  QRViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: Stack(
          children: [
            QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
              formatsAllowed: [BarcodeFormat.qrcode],
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_on),
                    color: Colors.white,
                    onPressed: () {
                      _controller.toggleFlash();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.flip_camera_android),
                    color: Colors.white,
                    onPressed: () {
                      _controller.flipCamera();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  var _keepUpdating = true;

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    _controller.scannedDataStream.listen((scanData) async {
      if (!_keepUpdating) {
        return;
      }

      try {
        final password = PasswordModel.fromUri(scanData.code);

        _keepUpdating = false;
        _controller.stopCamera();

        await password
            .save(Provider.of<Database>(context, listen: false).passwordDao);

        Navigator.of(context).pop();
      } on InvalidOTPUriException catch (e) {
        _showDialog(e.message);
      }
    });
  }

  void _showDialog(String message) async {
    _controller.pauseCamera();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid OTP QR Code'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });

    _controller.resumeCamera();
  }
}

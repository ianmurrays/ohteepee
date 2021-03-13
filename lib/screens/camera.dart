import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ohteepee/storage/database.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:base32/base32.dart';

import '../models/password.dart';
import '../redux/app_actions.dart';
import '../redux/app_state.dart';

class Camera extends StatefulWidget {
  static const route = '/camera';

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
        final password = _fromUri(scanData.code);

        _keepUpdating = false;
        _controller.stopCamera();

        final completer = Completer();

        StoreProvider.of<AppState>(context).dispatch(CreatePassword(
          password: password,
          completer: completer,
        ));

        await completer.future;

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

  static Password _fromUri(String uri) {
    String service;
    String account;
    String secret;
    int length;
    int period;
    Algorithm algorithm;
    bool timeBased;
    int counter;

    final parsed = Uri.parse(uri);

    if (parsed.scheme != 'otpauth') {
      throw InvalidOTPUriException('Scheme is not otpauth');
    }

    if (!['hotp', 'totp'].contains(parsed.host)) {
      throw InvalidOTPUriException('Type is not one of {hotp, totp}');
    }

    final issuerAccount = parsed.path.replaceFirst('/', '').split(':');

    if (issuerAccount.length != 2 && issuerAccount.length != 1) {
      throw InvalidOTPUriException('Invalid account / issuer provided');
    }

    if (issuerAccount.first.isEmpty ||
        (issuerAccount.length == 2 && issuerAccount[1].isEmpty)) {
      throw InvalidOTPUriException('Invalid account / issuer provided');
    }

    if (issuerAccount.length == 1) {
      account = Uri.decodeComponent(issuerAccount.first);
    } else {
      service = Uri.decodeComponent(issuerAccount[0]);
      account = Uri.decodeComponent(issuerAccount[1]);
    }

    if (!parsed.queryParameters.containsKey('secret') ||
        parsed.queryParameters['secret'].isEmpty) {
      throw InvalidOTPUriException('No secret provided');
    }

    try {
      base32.decodeAsHexString(parsed.queryParameters['secret']);
    } catch (FormatException) {
      throw InvalidOTPUriException('Secret is not valid base32');
    }

    secret = parsed.queryParameters['secret'];

    if (parsed.queryParameters.containsKey('algorithm')) {
      if (!['SHA1', 'SHA256', 'SHA512']
          .contains(parsed.queryParameters['algorithm'])) {
        throw InvalidOTPUriException(
            'Algorithm must be one of {SHA1, SHA256, SHA512}');
      }

      switch (parsed.queryParameters['algorithm']) {
        case 'SHA1':
          algorithm = Algorithm.SHA1;
          break;
        case 'SHA256':
          algorithm = Algorithm.SHA256;
          break;
        case 'SHA512':
          algorithm = Algorithm.SHA512;
          break;
        default:
          algorithm = Algorithm.SHA256;
      }
    }

    if (parsed.host == 'totp') {
      timeBased = true;

      period = _safeParseParameter(parsed.queryParameters, 'period', period);

      if (period < 15 || period > 600) {
        throw InvalidOTPUriException('Unsupported period length $period');
      }
    }

    if (parsed.host == 'hotp') {
      timeBased = false;

      counter = _safeParseParameter(parsed.queryParameters, 'counter', counter);

      if (counter < 0) {
        throw InvalidOTPUriException('Counter must be 0 or higher');
      }
    }

    length = _safeParseParameter(parsed.queryParameters, 'digits', length);

    if (length < 6 || length > 12) {
      throw InvalidOTPUriException('Digits must be between 6 and 12');
    }

    return Password((b) => b
      ..service = service
      ..account = account
      ..secret = secret
      ..length = length
      ..period = period
      ..algorithm = algorithm
      ..timeBased = timeBased
      ..counter = counter);
  }

  static int _safeParseParameter(
      Map<String, String> queryParameters, String property, int defaultValue) {
    if (queryParameters.containsKey(property)) {
      final parsed = int.tryParse(queryParameters[property]);

      if (parsed != null) {
        return parsed;
      } else {
        throw InvalidOTPUriException('$property is not valid');
      }
    }

    return defaultValue;
  }
}

class InvalidOTPUriException implements Exception {
  final String message;
  const InvalidOTPUriException(this.message);
}

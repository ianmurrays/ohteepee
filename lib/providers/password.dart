import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';

class Password with ChangeNotifier {
  final int id;
  String service;
  String account;
  String secret;
  int length;
  int period;
  String algorithm;
  bool timeBased;
  int counter;

  Password({
    @required this.id,
    this.service,
    @required this.account,
    @required this.secret,
    this.length = 6,
    this.period = 30,
    this.algorithm = 'SHA256',
    this.timeBased = true,
    this.counter,
  });

  String generateOTP() {
    if (timeBased) {
      return _generateTOTP();
    } else {
      return _generateHOTP();
    }
  }

  void increaseCounter() {
    if (timeBased) {
      return;
    }

    counter += 1;

    notifyListeners();
  }

  String _generateTOTP() {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      length: length,
      interval: period,
      algorithm: _algorithm,
    );
  }

  String _generateHOTP() {
    return OTP.generateHOTPCodeString(
      secret,
      counter,
      length: length,
      algorithm: _algorithm,
    );
  }

  Algorithm get _algorithm {
    switch (algorithm) {
      case 'SHA1':
        return Algorithm.SHA1;
      case 'SHA256':
        return Algorithm.SHA256;
      case 'SHA512':
        return Algorithm.SHA512;
      default:
        return Algorithm.SHA256;
    }
  }
}

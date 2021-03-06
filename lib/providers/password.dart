import 'package:flutter/foundation.dart';
import 'package:otp/otp.dart';
import 'package:base32/base32.dart';

class InvalidOTPUriException implements Exception {
  final String message;
  const InvalidOTPUriException(this.message);
}

int _safeParseParameter(
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

class Password with ChangeNotifier {
  int id;
  String service;
  String account;
  String secret;
  int length;
  int period;
  String algorithm;
  bool timeBased;
  int counter;

  Password({
    this.id,
    this.service,
    this.account,
    this.secret,
    this.length = 6,
    this.period = 30,
    this.algorithm = 'SHA256',
    this.timeBased = true,
    this.counter = 0,
  });

  Password.fromUri(String uri) {
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
      account = issuerAccount.first;
    } else {
      service = issuerAccount[0];
      account = issuerAccount[1];
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

      algorithm = parsed.queryParameters['algorithm'];
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
  }

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

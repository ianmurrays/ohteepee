import 'package:moor/moor.dart';
import 'package:otp/otp.dart' as otp;
import 'package:base32/base32.dart';

import '../storage/database.dart';

class InvalidOTPUriException implements Exception {
  final String message;
  const InvalidOTPUriException(this.message);
}

class Password {
  int id;
  String service;
  String account;
  String secret;
  int length;
  int period;
  Algorithm algorithm;
  bool timeBased;
  int counter;

  PasswordRow _dbModel;

  Password({
    this.id,
    this.service,
    this.account,
    this.secret,
    this.length = 6,
    this.period = 30,
    this.algorithm = Algorithm.SHA256,
    this.timeBased = true,
    this.counter = 0,
  });

  Password.fromDb(PasswordRow password) {
    _dbModel = password;

    id = password.id;
    service = password.service;
    account = password.account;
    length = password.length;
    period = password.period;
    algorithm = password.algorithm;
    timeBased = password.timeBased;
    counter = password.counter;
  }

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

      algorithm = _algorithmFromString(parsed.queryParameters['algorithm']);
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

  bool get isNew {
    return id == null;
  }

  PasswordsCompanion toCompanion() {
    return PasswordsCompanion(
      service: Value(service),
      account: Value(account),
      length: Value(length),
      period: Value(period),
      algorithm: Value(algorithm),
      timeBased: Value(timeBased),
      counter: Value(counter),
    );
  }

  PasswordRow toDbModel() {
    return _dbModel.copyWith(
      service: service,
      account: account,
      length: length,
      period: period,
      algorithm: algorithm,
      timeBased: timeBased,
      counter: counter,
    );
  }

  Future<String> generateOTP() {
    if (timeBased) {
      return _generateTOTP();
    } else {
      return _generateHOTP();
    }
  }

  Future<String> _generateTOTP() async {
    return otp.OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      length: length,
      interval: period,
      algorithm: _algorithm,
    );
  }

  Future<String> _generateHOTP() async {
    return otp.OTP.generateHOTPCodeString(
      secret,
      counter,
      length: length,
      algorithm: _algorithm,
    );
  }

  otp.Algorithm get _algorithm {
    switch (algorithm) {
      case Algorithm.SHA1:
        return otp.Algorithm.SHA1;
      case Algorithm.SHA256:
        return otp.Algorithm.SHA256;
      case Algorithm.SHA512:
        return otp.Algorithm.SHA512;
      default:
        return otp.Algorithm.SHA256;
    }
  }
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

Algorithm _algorithmFromString(String algorithm) {
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

import 'package:moor/moor.dart';
import 'package:otp/otp.dart' as otp;
import 'package:base32/base32.dart';

import '../storage/database.dart';

class InvalidOTPUriException implements Exception {
  final String message;
  const InvalidOTPUriException(this.message);
}

String generateOTP(Password password) {
  if (password.timeBased) {
    return _generateTOTP(password);
  } else {
    return _generateHOTP(password);
  }
}

Future increaseCounter(PasswordDao dao, Password password) {
  return dao.updatePassword(password.copyWith(counter: password.counter + 1));
}

PasswordsCompanion fromUri(String uri) {
  final parsed = Uri.parse(uri);
  final Map<String, dynamic> attributes = {};

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
    attributes['account'] = issuerAccount.first;
  } else {
    attributes['service'] = issuerAccount[0];
    attributes['account'] = issuerAccount[1];
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

  attributes['secret'] = parsed.queryParameters['secret'];

  if (parsed.queryParameters.containsKey('algorithm')) {
    if (!['SHA1', 'SHA256', 'SHA512']
        .contains(parsed.queryParameters['algorithm'])) {
      throw InvalidOTPUriException(
          'Algorithm must be one of {SHA1, SHA256, SHA512}');
    }

    attributes['algorithm'] =
        _algorithmFromString(parsed.queryParameters['algorithm']);
  }

  if (parsed.host == 'totp') {
    attributes['timeBased'] = true;

    attributes['period'] = _safeParseParameter(
        parsed.queryParameters, 'period', attributes['period']);

    if (attributes['period'] < 15 || attributes['period'] > 600) {
      throw InvalidOTPUriException(
          'Unsupported period length ${attributes['period']}');
    }
  }

  if (parsed.host == 'hotp') {
    attributes['timeBased'] = false;

    attributes['counter'] = _safeParseParameter(
        parsed.queryParameters, 'counter', attributes['counter']);

    if (attributes['counter'] < 0) {
      throw InvalidOTPUriException('Counter must be 0 or higher');
    }
  }

  attributes['length'] = _safeParseParameter(
      parsed.queryParameters, 'digits', attributes['length']);

  if (attributes['length'] < 6 || attributes['length'] > 12) {
    throw InvalidOTPUriException('Digits must be between 6 and 12');
  }

  return PasswordsCompanion(
    service: Value(attributes['service']),
    account: Value(attributes['account']),
    secret: Value(attributes['secret']),
    length: Value(attributes['length']),
    period: Value(attributes['period']),
    algorithm: Value(attributes['algorithm']),
    timeBased: Value(attributes['timeBased']),
    counter: Value(attributes['counter']),
  );
}

String _generateTOTP(Password password) {
  return otp.OTP.generateTOTPCodeString(
    password.secret,
    DateTime.now().millisecondsSinceEpoch,
    length: password.length,
    interval: password.period,
    algorithm: _algorithm(password.algorithm),
  );
}

String _generateHOTP(Password password) {
  return otp.OTP.generateHOTPCodeString(
    password.secret,
    password.counter,
    length: password.length,
    algorithm: _algorithm(password.algorithm),
  );
}

otp.Algorithm _algorithm(Algorithm algorithm) {
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

import 'package:built_value/built_value.dart';
import 'package:otp/otp.dart' as otp;

import '../storage/database.dart';

part 'password.g.dart';

abstract class Password implements Built<Password, PasswordBuilder> {
  @nullable
  int get id;

  @nullable
  String get service;

  String get account;

  String get secret;

  int get length;

  @nullable
  int get period;

  Algorithm get algorithm;

  bool get timeBased;

  @nullable
  int get counter;

  Password._();

  factory Password([void Function(PasswordBuilder) updates]) = _$Password;

  bool get hasService {
    return service != null && service.length > 0;
  }

  String generateOTP() {
    if (timeBased) {
      return _generateTOTP();
    } else {
      return _generateHOTP();
    }
  }

  String _generateTOTP() {
    return otp.OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      length: length,
      interval: period,
      algorithm: _algorithm,
    );
  }

  String _generateHOTP() {
    return otp.OTP.generateHOTPCodeString(
      secret,
      counter,
      length: length,
      algorithm: _algorithm,
    );
  }

  String get algorithmString {
    switch (algorithm) {
      case Algorithm.SHA1:
        return 'SHA1';
      case Algorithm.SHA256:
        return 'SHA256';
      case Algorithm.SHA512:
        return 'SHA512';
      default:
        return 'SHA256';
    }
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

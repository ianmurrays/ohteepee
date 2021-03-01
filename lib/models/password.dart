import 'package:flutter/foundation.dart';

class Password {
  final int id;
  final String service;
  final String account;
  final String secret;
  final int length;
  final int period;
  final String algorithm;
  final bool timeBased;
  final int counter;

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
}

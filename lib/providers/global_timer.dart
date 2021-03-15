import 'package:flutter/foundation.dart';
import 'dart:async';

class GlobalTimer with ChangeNotifier {
  DateTime date;

  GlobalTimer() {
    date = DateTime.now();

    // Effort to have timer as close as possible to zero milliseconds
    Timer(Duration(milliseconds: 1000 - date.millisecond), _startTimer);
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), _tick);
  }

  void _tick(Timer t) {
    date = DateTime.now();

    notifyListeners();
  }
}

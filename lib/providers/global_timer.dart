import 'package:flutter/foundation.dart';
import 'dart:async';

class GlobalTimer with ChangeNotifier {
  Timer _timer;

  DateTime date;

  GlobalTimer() {
    date = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  void _tick(Timer t) {
    date = DateTime.now();

    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import './password.dart';

class HomeScreen with ChangeNotifier {
  Set<Password> _selectedPasswords = Set();
  Set<Password> _shownPasswords = Set();

  Set<Password> get selectedPasswords {
    return Set.from(_selectedPasswords);
  }

  Set<Password> get shownPasswords {
    return Set.from(_shownPasswords);
  }

  void togglePassword(Password password) {
    if (_selectedPasswords.contains(password)) {
      _selectedPasswords.remove(password);
    } else {
      _selectedPasswords.add(password);
    }

    notifyListeners();
  }

  bool toggleShowPassword(Password password) {
    if (_shownPasswords.contains(password)) {
      _shownPasswords.remove(password);
    } else {
      _shownPasswords.add(password);
    }

    notifyListeners();

    return _shownPasswords.contains(password);
  }
}

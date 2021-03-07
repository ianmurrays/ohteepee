import 'package:flutter/foundation.dart';
import './password.dart';

class HomeScreen with ChangeNotifier {
  Set<int> _selectedPasswordIds = Set();
  Set<int> _shownPasswordIds = Set();

  Set<int> get selectedPasswords {
    return Set.from(_selectedPasswordIds);
  }

  Set<int> get shownPasswords {
    return Set.from(_shownPasswordIds);
  }

  void togglePassword(Password password) {
    if (_selectedPasswordIds.contains(password.id)) {
      _selectedPasswordIds.remove(password.id);
    } else {
      _selectedPasswordIds.add(password.id);
    }

    notifyListeners();
  }

  bool toggleShowPassword(Password password) {
    if (_shownPasswordIds.contains(password.id)) {
      _shownPasswordIds.remove(password.id);
    } else {
      _shownPasswordIds.add(password.id);
    }

    notifyListeners();

    return _shownPasswordIds.contains(password.id);
  }
}

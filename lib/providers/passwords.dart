import 'package:flutter/foundation.dart';

import './password.dart';

class Passwords with ChangeNotifier {
  final List<Password> _passwords = [
    // Dummy crap
    Password(
      id: 1,
      service: 'Google',
      account: 'test@example.com',
      secret: 'tu5niomvwnj6nlgwp3ar3svphe26bcbilsvvcdkfi6h5u5qwwk45cm6v',
    ),
    Password(
      id: 2,
      service: 'Amazon',
      account: 'test@example.com',
      period: 300,
      secret: 'otmqr2r2y2hz6wpoybmw3jzzloc5v4vhsvundzkctbjh65lhbkypoanx',
    ),
    Password(
      id: 3,
      service: 'HOTP',
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
      counter: 0,
      algorithm: 'SHA1',
      timeBased: false,
    ),
    Password(
      id: 34,
      service: 'Twitter',
      account: 'test@example.com',
      period: 120,
      algorithm: 'SHA512',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 35,
      service: 'Twitter',
      account: 'test@example.com',
      period: 60,
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 36,
      service: 'Twitter',
      account: 'test@example.com',
      period: 15,
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 37,
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 112,
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 113,
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 114,
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 115,
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
    Password(
      id: 116,
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
  ];

  List<Password> get passwords {
    return [..._passwords];
  }

  Password findById(int id) {
    return _passwords.firstWhere((element) => element.id == id);
  }

  void savePassword(Password password) {
    var existingIndex = _passwords.indexWhere((item) => item.id == password.id);

    if (existingIndex != -1) {
      print('exists');
      _passwords.replaceRange(existingIndex, existingIndex + 1, [password]);
    } else {
      print('new');
      password.id = DateTime.now().millisecondsSinceEpoch; // FIXME: temporary

      _passwords.add(password);
    }

    notifyListeners();
  }

  void deletePasswords(List<int> ids) {
    _passwords.removeWhere((element) => ids.contains(element.id));

    notifyListeners();
  }
}

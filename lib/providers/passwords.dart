import 'package:flutter/foundation.dart';

import '../models/password.dart';

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
      secret: 'otmqr2r2y2hz6wpoybmw3jzzloc5v4vhsvundzkctbjh65lhbkypoanx',
    ),
    Password(
      id: 3,
      service: 'Twitter',
      account: 'test@example.com',
      secret: 'kaof3kjfd6aeupiynis4fhb5vvkwp5a3sxepw3v432w4pvrbm3qbvpx3',
    ),
  ];

  List<Password> get passwords {
    return [..._passwords];
  }
}

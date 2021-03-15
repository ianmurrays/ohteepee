import 'dart:async';

import '../models/password.dart';

class LoadPasswords {}

class OnPasswordsLoaded {
  final List<Password> passwords;

  const OnPasswordsLoaded(this.passwords);
}

class CreatePassword {
  final Password password;
  final Completer completer;

  CreatePassword({this.password, Completer completer})
      : completer = completer ?? Completer();
}

class OnCreatePassword {
  final Password password;

  const OnCreatePassword(this.password);
}

class UpdatePassword {
  final Password password;

  final Completer completer;

  UpdatePassword({this.password, Completer completer})
      : completer = completer ?? Completer();
}

class OnUpdatePassword {
  final Password password;

  const OnUpdatePassword(this.password);
}

class DeleteSelectedPasswords {}

class OnDeletePassword {
  final Password password;

  const OnDeletePassword(this.password);
}

class ToggleDisplayPassword {
  final Password password;

  final bool show;

  ToggleDisplayPassword(this.password, [bool show]) : show = show ?? null;
}

class ClearDisplayedPasswords {}

class ToggleSelectPassword {
  final Password password;

  const ToggleSelectPassword(this.password);
}

class IncreasePasswordCounter {
  final Password password;
  final Completer completer;

  IncreasePasswordCounter({this.password, Completer completer})
      : completer = completer ?? Completer();
}

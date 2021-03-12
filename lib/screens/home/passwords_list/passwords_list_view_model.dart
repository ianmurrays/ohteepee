import 'package:redux/redux.dart';

import '../../../models/password.dart';
import '../../../redux/app_state.dart';

class PasswordsListViewModel {
  List<Password> passwords;

  Set<Password> selectedPasswords;

  Set<Password> shownPasswords;

  PasswordsListViewModel._();

  static PasswordsListViewModel fromStore(Store<AppState> store) {
    return PasswordsListViewModel._()
      ..passwords = store.state.passwords
      ..selectedPasswords = store.state.selectedPasswordIds
          .map((e) =>
              store.state.passwords.firstWhere((element) => element.id == e))
          .toSet()
      ..shownPasswords = store.state.shownPasswordIds
          .map((e) =>
              store.state.passwords.firstWhere((element) => element.id == e))
          .toSet();
  }
}

import 'package:redux/redux.dart';

import '../../redux/app_state.dart';
import '../../models/password.dart';

class HomeScreenViewModel {
  bool showEditButton;

  Password selectedPassword;

  bool showDeleteButton;

  bool showFab;

  bool isLoading;

  HomeScreenViewModel._();

  static HomeScreenViewModel fromStore(Store<AppState> store) {
    final selectedPassword = store.state.selectedPasswordIds.length == 1
        ? store.state.passwords.firstWhere(
            (element) => element.id == store.state.selectedPasswordIds.first)
        : null;

    return HomeScreenViewModel._()
      ..selectedPassword = selectedPassword
      ..showEditButton = selectedPassword != null
      ..showDeleteButton = store.state.selectedPasswordIds.length > 0
      ..showFab = store.state.selectedPasswordIds.length == 0
      ..isLoading = store.state.loadingPasswords;
  }
}

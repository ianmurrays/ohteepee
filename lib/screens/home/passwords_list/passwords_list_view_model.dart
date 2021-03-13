import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

import '../../../models/password.dart';
import '../../../redux/app_state.dart';

part 'passwords_list_view_model.g.dart';

abstract class PasswordsListViewModel
    implements Built<PasswordsListViewModel, PasswordsListViewModelBuilder> {
  BuiltList<Password> get passwords;

  BuiltSet<Password> get selectedPasswords;

  BuiltSet<Password> get shownPasswords;

  PasswordsListViewModel._();

  factory PasswordsListViewModel(
          [void Function(PasswordsListViewModelBuilder) updates]) =
      _$PasswordsListViewModel;

  static PasswordsListViewModel fromStore(Store<AppState> store) {
    return PasswordsListViewModel((b) => b
      ..passwords = store.state.passwords.toBuilder()
      ..selectedPasswords = SetBuilder(store.state.selectedPasswordIds.map(
          (e) =>
              store.state.passwords.firstWhere((element) => element.id == e)))
      ..shownPasswords = SetBuilder(store.state.shownPasswordIds.map((e) =>
          store.state.passwords.firstWhere((element) => element.id == e))));
  }
}

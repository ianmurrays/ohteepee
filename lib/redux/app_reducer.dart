import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

import '../models/password.dart';
import './app_actions.dart';
import './app_state.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, LoadPasswords>(_loadPasswords),
  TypedReducer<AppState, OnPasswordsLoaded>(_onPasswordsLoaded),
  TypedReducer<AppState, ToggleDisplayPassword>(_toggleDisplayPassword),
  TypedReducer<AppState, ToggleSelectPassword>(_toggleSelectPassword),
  TypedReducer<AppState, OnCreatePassword>(_onCreatePassword),
  TypedReducer<AppState, OnUpdatePassword>(_onUpdatePassword),
  TypedReducer<AppState, OnDeletePassword>(_onDeletePassword),
]);

AppState _loadPasswords(AppState state, LoadPasswords _action) {
  return state.rebuild((b) => b..loadingPasswords = true);
}

AppState _onPasswordsLoaded(AppState state, OnPasswordsLoaded action) {
  return state.rebuild((b) => b
    ..passwords = ListBuilder<Password>(action.passwords)
    ..loadingPasswords = false);
}

AppState _toggleDisplayPassword(AppState state, ToggleDisplayPassword action) {
  final show = action.show != null
      ? action.show
      : !state.shownPasswordIds.contains(action.password.id);

  return state.rebuild((b) => b
    ..shownPasswordIds.update((p) =>
        show ? p.add(action.password.id) : p.remove(action.password.id)));
}

AppState _toggleSelectPassword(AppState state, ToggleSelectPassword action) {
  Set<int> selectedPasswordIds;

  if (state.selectedPasswordIds.contains(action.password.id)) {
    selectedPasswordIds = Set.from(state.selectedPasswordIds)
      ..removeWhere((element) => element == action.password.id);
  } else {
    selectedPasswordIds = Set.from(state.selectedPasswordIds)
      ..add(action.password.id);
  }

  return state.rebuild(
      (b) => b..selectedPasswordIds = SetBuilder<int>(selectedPasswordIds));
}

AppState _onCreatePassword(AppState state, OnCreatePassword action) {
  return state
      .rebuild((b) => b..passwords.update((p) => p.add(action.password)));
}

AppState _onUpdatePassword(AppState state, OnUpdatePassword action) {
  final index =
      state.passwords.indexWhere((element) => element.id == action.password.id);

  return state.rebuild((b) => b
    ..passwords
        .update((p) => p..replaceRange(index, index + 1, [action.password])));
}

AppState _onDeletePassword(AppState state, OnDeletePassword action) {
  return state.rebuild((b) => b
    ..passwords.update(
        (p) => p.removeWhere((element) => element.id == action.password.id))
    ..selectedPasswordIds.update(
        (p) => p.removeWhere((element) => element == action.password.id))
    ..shownPasswordIds.update(
        (p) => p.removeWhere((element) => element == action.password.id)));
}

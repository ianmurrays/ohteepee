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
  TypedReducer<AppState, OnDeletePassword>(_onDeletePassword),
]);

AppState _loadPasswords(AppState state, LoadPasswords _action) {
  return AppState.fromState(state)..loadingPasswords = true;
}

AppState _onPasswordsLoaded(AppState state, OnPasswordsLoaded action) {
  return AppState.fromState(state)
    ..passwords = action.passwords
    ..loadingPasswords = false;
}

AppState _toggleDisplayPassword(AppState state, ToggleDisplayPassword action) {
  Set<int> shownPasswordIds;

  if (state.shownPasswordIds.contains(action.password.id)) {
    shownPasswordIds = Set.from(state.shownPasswordIds)
      ..removeWhere((element) => element == action.password.id);
  } else {
    shownPasswordIds = Set.from(state.shownPasswordIds)
      ..add(action.password.id);
  }

  return AppState.fromState(state)..shownPasswordIds = shownPasswordIds;
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

  return AppState.fromState(state)..selectedPasswordIds = selectedPasswordIds;
}

AppState _onCreatePassword(AppState state, OnCreatePassword action) {
  final List<Password> passwords = List.from(state.passwords)
    ..add(action.password);

  return AppState.fromState(state)..passwords = passwords;
}

AppState _onDeletePassword(AppState state, OnDeletePassword action) {
  final List<Password> passwords = List.from(state.passwords)
    ..removeWhere((element) => element.id == action.password.id);

  final Set<int> selectedPasswordIds = Set.from(state.selectedPasswordIds)
    ..removeWhere((element) => element == action.password.id);

  final Set<int> shownPasswordIds = Set.from(state.shownPasswordIds)
    ..removeWhere((element) => element == action.password.id);

  return AppState.fromState(state)
    ..passwords = passwords
    ..selectedPasswordIds = selectedPasswordIds
    ..shownPasswordIds = shownPasswordIds;
}

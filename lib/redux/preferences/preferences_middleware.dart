import 'package:ohteepee/redux/preferences/preferences_actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';

List<Middleware<AppState>> createPreferencesMiddleware() {
  return [
    TypedMiddleware<AppState, LoadPreferences>(_loadPreferences()),
    TypedMiddleware<AppState, ToggleCopyToClipboard>(_toggleCopyToClipboard()),
    TypedMiddleware<AppState, ToggleHidePasswords>(_toggleHidePasswords()),
  ];
}

void Function(
        Store<AppState> store, LoadPreferences action, NextDispatcher next)
    _loadPreferences() {
  return (store, action, next) async {
    next(action);

    final preferences = await SharedPreferences.getInstance();

    final copyToClipboard = preferences.getBool('copyToClipboard') ?? true;
    final hidePasswords = preferences.getBool('hidePasswords') ?? true;

    store.dispatch(OnPreferencesLoaded(
      copyToClipboard: copyToClipboard,
      hidePasswords: hidePasswords,
    ));
  };
}

void Function(Store<AppState> store, ToggleCopyToClipboard action,
    NextDispatcher next) _toggleCopyToClipboard() {
  return (store, action, next) async {
    next(action);

    final preferences = await SharedPreferences.getInstance();

    final value = action.copyToClipboard == null
        ? !store.state.preferences.copyToClipboard
        : action.copyToClipboard;

    await preferences.setBool('copyToClipboard', value);

    store.dispatch(OnPreferencesLoaded(
      copyToClipboard: value,
    ));
  };
}

void Function(
        Store<AppState> store, ToggleHidePasswords action, NextDispatcher next)
    _toggleHidePasswords() {
  return (store, action, next) async {
    next(action);

    final preferences = await SharedPreferences.getInstance();

    final value = action.hidePasswords == null
        ? !store.state.preferences.hidePasswords
        : action.hidePasswords;

    await preferences.setBool('hidePasswords', value);

    store.dispatch(OnPreferencesLoaded(
      hidePasswords: value,
    ));
  };
}

import 'package:ohteepee/redux/preferences/preferences_actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';

List<Middleware<AppState>> createPreferencesMiddleware() {
  return [
    TypedMiddleware<AppState, LoadPreferences>(_loadPreferences()),
    TypedMiddleware<AppState, ToggleCopyToClipboard>(_toggleCopyToClipboard()),
  ];
}

void Function(
        Store<AppState> store, LoadPreferences action, NextDispatcher next)
    _loadPreferences() {
  return (store, action, next) async {
    next(action);

    final preferences = await SharedPreferences.getInstance();

    final copyToClipboard = preferences.getBool('copyToClipboard') ?? true;

    store.dispatch(OnPreferencesLoaded(
      copyToClipboard: copyToClipboard,
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

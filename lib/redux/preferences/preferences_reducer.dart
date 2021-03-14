import 'package:redux/redux.dart';

import '../app_state.dart';
import './preferences_actions.dart';

final preferencesReducer = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, LoadPreferences>(_loadPreferences),
  TypedReducer<AppState, OnPreferencesLoaded>(_onPreferencesLoaded),
];

AppState _loadPreferences(AppState state, LoadPreferences action) {
  return state.rebuild((b) => b..startingUp = true);
}

AppState _onPreferencesLoaded(AppState state, OnPreferencesLoaded action) {
  return state.rebuild((b) => b
    ..startingUp = false
    ..preferences.update((p) => p..copyToClipboard = action.copyToClipboard));
}

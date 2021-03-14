import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:ohteepee/redux/preferences/preferences_state.dart';

import '../models/password.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  bool get startingUp;

  BuiltSet<int> get selectedPasswordIds;

  BuiltSet<int> get shownPasswordIds;

  bool get loadingPasswords;

  BuiltList<Password> get passwords;

  PreferencesState get preferences;

  AppState._();

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.init() => AppState((b) => b
    ..startingUp = true
    ..selectedPasswordIds = SetBuilder()
    ..shownPasswordIds = SetBuilder()
    ..loadingPasswords = false
    ..passwords = ListBuilder()
    ..preferences = PreferencesState.init().toBuilder());
}

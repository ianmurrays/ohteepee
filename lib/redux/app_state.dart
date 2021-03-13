import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import '../models/password.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  BuiltSet<int> get selectedPasswordIds;

  BuiltSet<int> get shownPasswordIds;

  bool get loadingPasswords;

  BuiltList<Password> get passwords;

  AppState._();

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.init() => AppState((b) => b
    ..selectedPasswordIds = SetBuilder()
    ..shownPasswordIds = SetBuilder()
    ..loadingPasswords = false
    ..passwords = ListBuilder());
}

import '../models/password.dart';

class AppState {
  Set<int> selectedPasswordIds;
  Set<int> shownPasswordIds;

  bool loadingPasswords;

  List<Password> passwords;

  AppState._();

  factory AppState.init() => AppState._()
    ..selectedPasswordIds = Set()
    ..shownPasswordIds = Set()
    ..loadingPasswords = false
    ..passwords = [];

  static fromState(AppState state) => AppState.init()
    ..selectedPasswordIds = Set.from(state.selectedPasswordIds)
    ..shownPasswordIds = Set.from(state.shownPasswordIds)
    ..passwords = List.from(state.passwords);
}

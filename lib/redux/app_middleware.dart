import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moor/moor.dart';
import 'package:redux/redux.dart';

import './app_actions.dart';
import './app_state.dart';
import '../storage/database.dart';
import '../models/password.dart';

List<Middleware<AppState>> createStoreMiddleware(PasswordDao dao) {
  return [
    TypedMiddleware<AppState, LoadPasswords>(_loadPasswords(dao)),
    TypedMiddleware<AppState, IncreasePasswordCounter>(
        _increasePasswordCounter(dao)),
    TypedMiddleware<AppState, CreatePassword>(_createPassword(dao)),
    TypedMiddleware<AppState, UpdatePassword>(_updatePassword(dao)),
    TypedMiddleware<AppState, DeleteSelectedPasswords>(
        _deleteSelectedPasswords(dao)),
  ];
}

void Function(Store<AppState> store, LoadPasswords action, NextDispatcher next)
    _loadPasswords(PasswordDao dao) {
  return (store, action, next) async {
    next(action);

    final passwordRows = await dao.selectAll();
    final futures = passwordRows.map((row) async {
      final secret = await FlutterSecureStorage().read(key: row.id.toString());

      return Password.fromDb(row)..secret = secret;
    });

    store.dispatch(OnPasswordsLoaded(await Future.wait(futures)));
  };
}

void Function(Store<AppState> store, IncreasePasswordCounter action,
    NextDispatcher next) _increasePasswordCounter(PasswordDao dao) {
  return (store, action, next) async {
    next(action);

    try {
      await dao.updatePassword(
          action.password.id,
          PasswordsCompanion(
            counter: Value(action.password.counter + 1),
          ));

      // FIXME: This should be some new password model, not modified in place
      action.password.counter += 1;

      action.completer.complete();
    } catch (e) {
      action.completer.completeError(e);
    }
  };
}

void Function(Store<AppState> store, CreatePassword action, NextDispatcher next)
    _createPassword(PasswordDao dao) {
  return (store, action, next) async {
    next(action);

    final id = await dao.insertPassword(action.password.toCompanion());
    final passwordRow = await dao.findById(id);

    await FlutterSecureStorage().write(
      key: id.toString(),
      value: action.password.secret,
    );

    store.dispatch(OnCreatePassword(
        Password.fromDb(passwordRow)..secret = action.password.secret));

    action.completer.complete();
  };
}

void Function(Store<AppState> store, UpdatePassword action, NextDispatcher next)
    _updatePassword(PasswordDao dao) {
  return (store, action, next) async {
    next(action);

    await dao.updatePassword(action.password.id, action.password.toCompanion());

    await FlutterSecureStorage().write(
      key: action.password.id.toString(),
      value: action.password.secret,
    );

    store.dispatch(LoadPasswords());

    action.completer.complete();
  };
}

void Function(Store<AppState> store, DeleteSelectedPasswords action,
    NextDispatcher next) _deleteSelectedPasswords(PasswordDao dao) {
  return (store, action, next) async {
    next(action);

    store.state.passwords
        .where(
            (element) => store.state.selectedPasswordIds.contains(element.id))
        .forEach((password) async {
      await dao.deletePassword(password.toDbModel());
      await FlutterSecureStorage().delete(
        key: password.id.toString(),
      );

      store.dispatch(OnDeletePassword(password));
    });
  };
}

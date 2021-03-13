import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/password.dart';
import '../redux/app_actions.dart';
import '../redux/app_state.dart';
import './form.dart';

class EditPassword extends StatelessWidget {
  static const route = '/edit';

  final Password password;

  const EditPassword({Key key, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnSavePasswordCallback>(
      converter: (store) {
        return ({
          service,
          account,
          secret,
          length,
          period,
          algorithm,
          timeBased,
          counter,
        }) async {
          final update = Password((b) => b
            ..id = password.id
            ..service = service
            ..account = account
            ..secret = secret
            ..length = length
            ..period = period
            ..algorithm = algorithm
            ..timeBased = timeBased
            ..counter = counter
          );

          final completer = Completer();

          store.dispatch(UpdatePassword(
            password: update,
            completer: completer,
          ));

          await completer.future;

          Navigator.of(context).pop();
        };
      },
      builder: (context, callback) {
        return PasswordForm(
          password: password,
          onSave: callback,
        );
      },
    );
  }
}

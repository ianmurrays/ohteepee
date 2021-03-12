import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/password.dart';
import '../redux/app_actions.dart';
import '../redux/app_state.dart';
import './form.dart';

class AddPassword extends StatelessWidget {
  static const route = '/new';

  const AddPassword({Key key}) : super(key: key);

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
          final password = Password(
            service: service,
            account: account,
            secret: secret,
            length: length,
            period: period,
            algorithm: algorithm,
            timeBased: timeBased,
            counter: counter,
          );

          final completer = Completer();

          store.dispatch(CreatePassword(
            password: password,
            completer: completer,
          ));

          await completer.future;

          Navigator.of(context).pop();
        };
      },
      builder: (context, callback) {
        return PasswordForm(
          onSave: callback,
        );
      },
    );
  }
}

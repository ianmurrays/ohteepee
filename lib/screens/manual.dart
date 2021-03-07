import 'package:flutter/material.dart';
import 'package:ohteepee/providers/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/passwords.dart';
import '../providers/password.dart';
import '../widgets/otp_form.dart';

class Manual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Password model;
    final passwords =
        Provider.of<HomeScreen>(context, listen: false).selectedPasswords;
    final passwordsProvider = Provider.of<Passwords>(context, listen: false);

    if (passwords.length == 1) {
      model = Password.from(passwordsProvider.findById(passwords.first));
    } else {
      model = Password();
    }

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: passwords.length == 1
            ? const Text('Edit OTP')
            : const Text('Add OTP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // FIXME: need to update the password somehow
                passwordsProvider.savePassword(model);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: OTPForm(
        model: model,
        formKey: _formKey,
      ),
    );
  }
}

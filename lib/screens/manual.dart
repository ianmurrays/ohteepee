import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/passwords.dart';
import '../providers/password.dart';
import '../widgets/otp_form.dart';

class Manual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Password();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Add OTP'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Provider.of<Passwords>(context, listen: false)
                    .addPassword(model);

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

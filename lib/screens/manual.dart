import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen.dart';
import '../storage/database.dart';
import '../storage/password_model.dart';
import '../widgets/otp_form.dart';

class Manual extends StatefulWidget {
  final PasswordModel model;

  Manual({this.model});

  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title:
            widget.model.isNew ? const Text('Add OTP') : const Text('Edit OTP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                final db = Provider.of<Database>(context, listen: false);

                await widget.model.save(db.passwordDao);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: OTPForm(
        model: widget.model,
        formKey: _formKey,
      ),
    );
  }
}

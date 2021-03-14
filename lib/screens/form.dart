import 'package:flutter/material.dart';
import 'package:base32/base32.dart';

import '../storage/database.dart';
import '../models/password.dart';

typedef OnSavePasswordCallback = void Function({
  String service,
  String account,
  String secret,
  int length,
  int period,
  Algorithm algorithm,
  bool timeBased,
  int counter,
});

class PasswordForm extends StatefulWidget {
  final OnSavePasswordCallback onSave;
  final Password password;

  PasswordForm({Key key, this.onSave, this.password}) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();

  var _showAdvancedFields = false;

  String service;
  String account = '';
  String secret = '';
  int length = 6;
  int period = 30;
  Algorithm algorithm = Algorithm.SHA256;
  bool timeBased = true;
  int counter = 0;

  @override
  void initState() {
    super.initState();

    if (widget.password != null) {
      service = widget.password.service;
      account = widget.password.account;
      secret = widget.password.secret;
      length = widget.password.length;
      period = widget.password.period;
      algorithm = widget.password.algorithm;
      timeBased = widget.password.timeBased;
      counter = widget.password.counter;
    }
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      widget.onSave(
        service: service,
        account: account,
        secret: secret,
        length: length,
        period: period,
        algorithm: algorithm,
        timeBased: timeBased,
        counter: counter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.password == null
            ? const Text('Add OTP')
            : const Text('Edit OTP'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    final advancedFields = [
      _margin(
        child: DropdownButtonFormField(
          decoration: _borderDecoration(
            labelText: 'Algorithm',
          ),
          items: [
            const DropdownMenuItem(
              child: Text('SHA1'),
              value: Algorithm.SHA1,
            ),
            const DropdownMenuItem(
              child: Text('SHA256'),
              value: Algorithm.SHA256,
            ),
            const DropdownMenuItem(
              child: Text('SHA512'),
              value: Algorithm.SHA512,
            ),
          ],
          value: algorithm,
          onChanged: (value) {
            setState(() {
              algorithm = value;
            });
          },
        ),
      ),
      _margin(
        child: TextFormField(
          decoration: _borderDecoration(
            labelText: 'Length',
          ),
          initialValue: length.toString(),
          onChanged: (value) {
            setState(() {
              try {
                length = int.parse(value);
              } catch (e) {
                length = 6;
              }
            });
          },
          validator: (value) {
            final intValue = int.tryParse(value);

            if (intValue == null) {
              return 'Length should be a number';
            }

            if (intValue < 6) {
              return "Length can't be less than 6";
            }

            if (intValue > 12) {
              return "Length can't be more than 12";
            }

            return null;
          },
        ),
      ),
      _margin(
        child: SwitchListTile.adaptive(
          title: const Text('Time-based'),
          value: timeBased,
          onChanged: (value) {
            setState(() {
              timeBased = value;
            });
          },
        ),
      ),
      timeBased
          ? _margin(
              child: TextFormField(
                key: const ValueKey('periodField'),
                decoration: _borderDecoration(
                  labelText: 'Period',
                ),
                initialValue: period.toString(),
                onChanged: (value) {
                  setState(() {
                    try {
                      period = int.parse(value);
                    } catch (e) {
                      period = 30;
                    }
                  });
                },
                validator: (value) {
                  final intValue = int.tryParse(value);

                  if (intValue == null) {
                    return 'Period should be a number';
                  }

                  if (intValue < 30) {
                    return "Period can't be less than 30";
                  }

                  if (intValue > 300) {
                    return "Period can't be more than 300";
                  }

                  return null;
                },
              ),
            )
          : _margin(
              child: TextFormField(
                key: const ValueKey('counterField'),
                decoration: _borderDecoration(
                  labelText: 'Counter',
                ),
                initialValue: counter.toString(),
                onChanged: (value) {
                  setState(() {
                    try {
                      counter = int.parse(value);
                    } catch (e) {
                      counter = 0;
                    }
                  });
                },
                validator: (value) {
                  final intValue = int.tryParse(value);

                  if (intValue == null) {
                    return 'Counter should be a number';
                  }

                  if (intValue < 0) {
                    return "Counter can't be less than 0";
                  }

                  return null;
                },
              ),
            ),
    ];

    return Container(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _margin(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                child: TextFormField(
                  initialValue: service,
                  textCapitalization: TextCapitalization.words,
                  decoration: _borderDecoration(
                    labelText: 'Service',
                    hintText: 'eg. Google',
                    helperText: 'Optional',
                    prefixIcon: Icon(Icons.bubble_chart,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            .color),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        service = null;
                      } else {
                        service = value;
                      }
                    });
                  },
                ),
              ),
              _margin(
                child: TextFormField(
                  initialValue: account,
                  decoration: _borderDecoration(
                    labelText: 'Account',
                    hintText: 'robot@example.org',
                    prefixIcon: Icon(Icons.person,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            .color),
                  ),
                  onChanged: (value) {
                    setState(() {
                      account = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'An account name is required';
                    }

                    return null;
                  },
                ),
              ),
              _margin(
                child: TextFormField(
                  initialValue: secret,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: _borderDecoration(
                    labelText: 'Secret',
                    prefixIcon: Icon(Icons.vpn_key,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle
                            .color),
                  ),
                  onChanged: (value) {
                    setState(() {
                      secret = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'A secret is required';
                    }

                    try {
                      base32.decodeAsHexString(value);
                    } on FormatException {
                      return 'This secret is not valid Base32';
                    }

                    return null;
                  },
                ),
              ),
              _margin(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                child: ListTile(
                  title: const Text('Advanced'),
                  trailing: Icon(
                    _showAdvancedFields ? Icons.expand_more : Icons.expand_less,
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  onTap: () {
                    setState(() {
                      _showAdvancedFields = !_showAdvancedFields;
                    });
                  },
                ),
              ),
              if (_showAdvancedFields) ...advancedFields,
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _borderDecoration(
      {String labelText, String hintText, String helperText, Icon prefixIcon}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
    );
  }

  Widget _margin(
      {EdgeInsets margin = const EdgeInsets.symmetric(
        vertical: 10,
      ),
      Widget child}) {
    return Container(
      margin: margin,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class Manual extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManualState();
  }
}

class ManualState extends State<Manual> {
  final _formKey = GlobalKey<FormState>();
  final _accountFocusNode = FocusNode();
  final _secretFocusNode = FocusNode();
  bool _formDirty = false;

  final Map<String, dynamic> formData = {
    'service': null,
    'account': null,
    'secret': null,
    'timeBased': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: _onClosePressed,
        ),
        title: Text('Manually Add OTP'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _onSavePressed,
          ),
        ],
      ),
      body: Form(
        onChanged: () {
          setState(() {
            _formDirty = true;
          });
        },
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _pad(child: _buildServiceField(context)),
            _pad(child: _buildAccountField(context)),
            _pad(child: _buildSecretField()),
            _pad(
                child: _buildTimeBasedSwitch(),
                padding: EdgeInsets.only(top: 20, left: 30, right: 20)),
          ],
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(formData);
      Navigator.of(context).pop();
    }
  }

  void _onClosePressed() async {
    if (!_formDirty || await _buildShowDialog(context)) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirm something?'),
            content: Text('Are you super sure?'),
            actions: <Widget>[
              FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
            ],
          );
        });
  }

  Widget _pad(
      {Widget child,
      EdgeInsets padding =
          const EdgeInsets.only(top: 20, left: 20, right: 20)}) {
    return Padding(padding: padding, child: child);
  }

  Row _buildTimeBasedSwitch() {
    return Row(
      children: <Widget>[
        Text('Time-based', style: TextStyle(fontSize: 16)),
        Flexible(child: Container()),
        Switch(
          value: formData['timeBased'],
          onChanged: (bool value) {
            setState(() {
              _formDirty = true;
              formData['timeBased'] = value;
            });
          },
        )
      ],
    );
  }

  TextFormField _buildSecretField() {
    return TextFormField(
      focusNode: _secretFocusNode,
      decoration: InputDecoration(
          labelText: 'Secret',
          border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
          prefixIcon: Icon(Icons.vpn_key)),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          formData['secret'] = value;
        });
      },
    );
  }

  TextFormField _buildAccountField(BuildContext context) {
    return TextFormField(
      focusNode: _accountFocusNode,
      decoration: InputDecoration(
          labelText: 'Account',
          hintText: 'eg. myaccount@gmail.com',
          border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
          prefixIcon: Icon(Icons.person)),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_secretFocusNode);
      },
      onSaved: (String value) {
        setState(() {
          formData['account'] = value;
        });
      },
    );
  }

  TextFormField _buildServiceField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
          labelText: 'Service',
          hintText: 'eg. Google',
          border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
          prefixIcon: Icon(Icons.bubble_chart),
          helperText: 'Optional'),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_accountFocusNode);
      },
      onSaved: (String value) {
        setState(() {
          formData['service'] = value;
        });
      },
    );
  }
}

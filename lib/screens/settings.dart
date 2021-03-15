import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/preferences/preferences_actions.dart';
import '../redux/app_state.dart';
import './settings_view_model.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsViewModel>(
        converter: SettingsViewModel.fromStore,
        builder: (context, vm) => Scaffold(
              appBar: AppBar(
                title: const Text('Settings'),
                centerTitle: Platform.isIOS,
              ),
              body: ListView(
                padding: EdgeInsets.only(top: 10),
                children: [
                  SwitchListTile.adaptive(
                    title: Text('Copy OTPs to clipboard on tap'),
                    value: vm.copyToClipboard,
                    onChanged: (value) {
                      StoreProvider.of<AppState>(context)
                          .dispatch(ToggleCopyToClipboard(value));
                    },
                  ),
                  Divider(),
                  SwitchListTile.adaptive(
                    title: Text('Hide OTPs until tapped'),
                    value: vm.hidePasswords,
                    onChanged: (value) {
                      StoreProvider.of<AppState>(context)
                          .dispatch(ToggleHidePasswords(value));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: const Text('About'),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationVersion: '1.0.0',
                        applicationLegalese: '''Copyright 2021 Ian Murray

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.''',
                      );
                    },
                  )
                ],
              ),
            ));
  }
}

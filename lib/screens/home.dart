import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen.dart';
import '../widgets/passwords_list_view.dart';
import '../widgets/home_floating_action_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oh Tee Pee'),
        actions: <Widget>[
          if (Provider.of<HomeScreen>(context).selectedPasswords.length == 1)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => print('edit'),
            ),
          if (Provider.of<HomeScreen>(context).selectedPasswords.length >= 1)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => print('delete'),
            ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => print('settings'),
          ),
        ],
      ),
      floatingActionButton: HomeFloatingActionButton(),
      body: PasswordsListView(),
    );
  }
}

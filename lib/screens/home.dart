import 'package:flutter/material.dart';

import '../widgets/passwords_list_view.dart';
import '../widgets/home_floating_action_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oh Tee Pee'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => print('settings'),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => print('edit'),
          )
        ],
      ),
      floatingActionButton: HomeFloatingActionButton(),
      body: PasswordsListView(),
    );
  }
}

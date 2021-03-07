import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen.dart';
import '../widgets/passwords_list_view.dart';
import '../widgets/home_floating_action_button.dart';
import '../screens/manual.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeScreen = Provider.of<HomeScreen>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oh Tee Pee'),
        actions: [
          if (homeScreen.selectedPasswords.length == 1)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Manual(), fullscreenDialog: true);

                Navigator.of(context).push(route);
              },
            ),
          if (homeScreen.selectedPasswords.length >= 1)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => print('delete'),
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => print('settings'),
          ),
        ],
      ),
      floatingActionButton: homeScreen.selectedPasswords.length == 0
          ? HomeFloatingActionButton()
          : null,
      body: PasswordsListView(),
    );
  }
}

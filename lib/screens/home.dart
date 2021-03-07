import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen.dart';
import '../providers/passwords.dart';
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
          if (homeScreen.selectedPasswordIds.length == 1)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Manual(), fullscreenDialog: true);

                Navigator.of(context).push(route);
              },
            ),
          if (homeScreen.selectedPasswordIds.length >= 1)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm deletion'),
                        content: const Text(
                            'Are you sure you want to delete these passwords? This cannot be undone.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel')),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    });

                if (!result) {
                  return;
                }

                final passwordIds = homeScreen.selectedPasswordIds;

                Provider.of<Passwords>(context, listen: false)
                    .deletePasswords(passwordIds.toList());

                homeScreen.reset();
              },
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => print('settings'),
          ),
        ],
      ),
      floatingActionButton: homeScreen.selectedPasswordIds.length == 0
          ? HomeFloatingActionButton()
          : null,
      body: PasswordsListView(),
    );
  }
}

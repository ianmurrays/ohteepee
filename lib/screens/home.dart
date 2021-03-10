import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../storage/database.dart';
import '../storage/password_model.dart';
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
          if (homeScreen.selectedPasswordIds.length == 1)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final passwordIds =
                    Provider.of<HomeScreen>(context, listen: false)
                        .selectedPasswordIds;

                if (passwordIds.length != 1) {
                  return;
                }

                // Edit
                final model = PasswordModel.fromDb(
                    await Provider.of<Database>(context, listen: false)
                        .passwordDao
                        .findById(passwordIds.first));

                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Manual(model: model),
                    fullscreenDialog: true);

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

                final dao =
                    Provider.of<Database>(context, listen: false).passwordDao;

                final futures = passwordIds.map((id) async {
                  final password = PasswordModel.fromDb(await dao.findById(id));

                  await password.delete(dao);
                });

                await Future.wait(futures);

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

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/app_actions.dart';
import '../../redux/app_state.dart';
import '../../screens/edit_password.dart';
import './home_floating_action_button.dart';
import './home_screen_view_model.dart';
import './passwords_list/passwords_list.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/';

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeScreenViewModel>(
      converter: HomeScreenViewModel.fromStore,
      builder: (context, vm) {
        if (vm.isLoading) {
          return Scaffold(
            appBar: AppBar(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Oh Tee Pee'),
            actions: [
              if (vm.showEditButton)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditPassword.route,
                        arguments: vm.selectedPassword);
                  },
                ),
              if (vm.showDeleteButton)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirm deletion'),
                            content: const Text(
                              'Are you sure you want to delete these passwords? This cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel')),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
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

                    StoreProvider.of<AppState>(context)
                        .dispatch(DeleteSelectedPasswords());
                  },
                ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => print('settings'),
              ),
            ],
          ),
          floatingActionButton: vm.showFab ? HomeFloatingActionButton() : null,
          body: PasswordsListView(),
        );
      },
    );
  }
}

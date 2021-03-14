import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/app_actions.dart';
import '../../redux/app_state.dart';
import '../../screens/edit_password.dart';
import '../settings.dart';
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
            centerTitle: Platform.isIOS,
            actions: [
              if (vm.showEditButton)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_ctx) => EditPassword(
                        password: vm.selectedPassword,
                      ),
                      fullscreenDialog: true,
                    ));
                  },
                ),
              if (vm.showDeleteButton)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final result = await _confirmDialog(context);

                    if (!result) {
                      return;
                    }

                    StoreProvider.of<AppState>(context)
                        .dispatch(DeleteSelectedPasswords());
                  },
                ),
              if (vm.showSettings)
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_ctx) => Settings(),
                      fullscreenDialog: true,
                    ));
                  },
                ),
            ],
          ),
          floatingActionButton: vm.showFab ? HomeFloatingActionButton() : null,
          body: PasswordsListView(),
        );
      },
    );
  }

  Future<bool> _confirmDialog(BuildContext context) {
    const Text title = const Text('Confirm deletion');
    const Text content = const Text(
        'Are you sure you want to delete these passwords? This cannot be undone.');

    Widget Function(BuildContext context) dialog;

    if (Platform.isIOS) {
      dialog = (ctx) => CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel')),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
    } else {
      dialog = (ctx) => AlertDialog(
            title: title,
            content: content,
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
    }

    return showDialog(
        barrierDismissible: !Platform.isIOS,
        barrierColor: Platform.isIOS ? Colors.transparent : Colors.black54,
        context: context,
        builder: (context) => dialog(context));
  }
}

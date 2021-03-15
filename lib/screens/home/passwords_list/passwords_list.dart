import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../redux/app_state.dart';
import './password_tile.dart';
import './passwords_list_view_model.dart';

class PasswordsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordsListViewModel>(
      converter: PasswordsListViewModel.fromStore,
      builder: (context, vm) {
        if (vm.passwords.isEmpty) {
          return _emptyView();
        }

        return ListView.separated(
          padding: const EdgeInsets.only(
            bottom: 72,
          ),
          itemCount: vm.passwords.length,
          itemBuilder: (ctx, index) {
            final password = vm.passwords[index];

            return PasswordTile(
              password: password,
              isHideable: vm.hidePasswords,
              isShown:
                  !vm.hidePasswords || vm.shownPasswords.contains(password),
              isSelected: vm.selectedPasswords.contains(password),
              anySelected: vm.selectedPasswords.length > 0,
              copyToClipboard: vm.copyToClipboard,
            );
          },
          separatorBuilder: (_ctx, index) => const Divider(
            height: 1,
          ),
        );
      },
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '😔',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('No passwords added yet')
        ],
      ),
    );
  }
}

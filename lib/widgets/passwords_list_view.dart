import 'package:flutter/material.dart';
import 'package:ohteepee/widgets/password_tile.dart';
import 'package:provider/provider.dart';

import '../providers/passwords.dart';

class PasswordsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final passwordsProvider = Provider.of<Passwords>(context);

    return ListView.separated(
      padding: EdgeInsets.only(
        bottom: 72,
      ),
      itemCount: passwordsProvider.passwords.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: passwordsProvider.passwords[index],
          child: PasswordTile(),
        );
      },
      separatorBuilder: (_ctx, index) => Divider(
        height: 1,
      ),
    );
  }
}

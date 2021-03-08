import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/password_tile.dart';
import '../storage/database.dart';
import '../storage/password_model.dart';

class PasswordsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final passwordsDao = Provider.of<Database>(context).passwordDao;

    return StreamBuilder(
      stream: passwordsDao.watchAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          return ListView.separated(
            padding: const EdgeInsets.only(
              bottom: 72,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, index) {
              return Provider.value(
                value: PasswordModel.fromDb(snapshot.data[index]),
                child: PasswordTile(),
              );
            },
            separatorBuilder: (_ctx, index) => const Divider(
              height: 1,
            ),
          );
        } else if (snapshot.hasData && snapshot.data.length == 0) {
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
        } else {
          return Container();
        }
      },
    );
  }
}

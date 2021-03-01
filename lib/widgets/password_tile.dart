import 'package:flutter/material.dart';

import '../models/password.dart';

class PasswordTile extends StatelessWidget {
  final Password password;

  PasswordTile(this.password);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(password.id),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            password.service.substring(0, 1),
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Text(password.service),
          SizedBox(width: 5,),
          Text('(${password.account})', style: TextStyle(color: Colors.grey),),
        ],
      ),
      subtitle: Text(
        '123 456',
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

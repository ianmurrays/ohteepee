import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './circular_time_remaining_indicator.dart';
import '../providers/global_timer.dart';
import '../providers/password.dart';

class PasswordTile extends StatefulWidget {
  @override
  _PasswordTileState createState() => _PasswordTileState();
}

class _PasswordTileState extends State<PasswordTile> {
  bool _hidden = true;

  Widget _trailingWidget(Password password) {
    if (_hidden) {
      return null;
    }

    if (password.timeBased) {
      return Consumer<GlobalTimer>(
        builder: (_ctx, timer, _child) {
          return CircularTimeRemainingIndicator(
            period: password.period,
            second: timer.date.minute * 60 + timer.date.second,
          );
        },
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.refresh,
          size: 30,
        ),
        onPressed: () {
          password.increaseCounter();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final password = Provider.of<Password>(context);

    return ListTile(
      onTap: () {
        setState(() {
          _hidden = !_hidden;
        });
      },
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
          SizedBox(
            width: 5,
          ),
          Text(
            '(${password.account})',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      subtitle: _hidden
          ? Text('••••••')
          : Consumer<GlobalTimer>(
              builder: (_ctx, timer, _child) {
                return Text(
                  password.generateOTP(),
                  style: TextStyle(fontSize: 25),
                );
              },
            ),
      trailing: _trailingWidget(password),
    );
  }
}

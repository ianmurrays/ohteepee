import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohteepee/providers/home_screen.dart';
import 'package:provider/provider.dart';

import './circular_time_remaining_indicator.dart';
import '../providers/global_timer.dart';
import '../providers/password.dart';

class PasswordTile extends StatelessWidget {
  Widget _trailingWidget(BuildContext context, Password password) {
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
          _copyToClipboard(context, password);
        },
      );
    }
  }

  void _copyToClipboard(BuildContext context, Password password) async {
    await Clipboard.setData(ClipboardData(text: password.generateOTP()));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
  }

  @override
  Widget build(BuildContext context) {
    final password = Provider.of<Password>(context);
    final homeScreen = Provider.of<HomeScreen>(context);
    final selected = homeScreen.selectedPasswords.contains(password);
    final anySelected = homeScreen.selectedPasswords.length >= 1;
    final shown = homeScreen.shownPasswords.contains(password);

    return ListTile(
      onTap: () {
        if (anySelected) {
          homeScreen.togglePassword(password);
        } else {
          final shown = homeScreen.toggleShowPassword(password);

          if (shown) {
            _copyToClipboard(context, password);
          }
        }
      },
      onLongPress: () {
        Provider.of<HomeScreen>(context, listen: false)
            .togglePassword(password);
      },
      selected: selected,
      selectedTileColor: Theme.of(context).selectedRowColor,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: selected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Text(
                  (password.service != null
                          ? password.service.substring(0, 1)
                          : password.account.substring(0, 1))
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
      title: _title(password),
      subtitle: shown
          ? Consumer<GlobalTimer>(
              builder: (_ctx, timer, _child) {
                return Text(
                  password.generateOTP(),
                  style: TextStyle(fontSize: 25),
                );
              },
            )
          : Text('••••••'),
      trailing: shown ? _trailingWidget(context, password) : null,
    );
  }

  Widget _title(password) {
    if (password.service != null) {
      return Row(
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
      );
    } else {
      return Text(password.account);
    }
  }
}

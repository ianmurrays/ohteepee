import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen.dart';
import '../providers/global_timer.dart';
import './circular_time_remaining_indicator.dart';
import '../storage/database.dart';
import '../storage/password_model.dart';
// import '../storage/password_utils.dart';

class PasswordTile extends StatelessWidget {
  Widget _trailingWidget(BuildContext context, PasswordModel password) {
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
        icon: const Icon(
          Icons.refresh,
          size: 30,
        ),
        onPressed: () async {
          await password.increaseCounter(
              Provider.of<Database>(context, listen: false).passwordDao);

          _copyToClipboard(context, password);
        },
      );
    }
  }

  void _copyToClipboard(BuildContext context, PasswordModel password) async {
    await Clipboard.setData(ClipboardData(text: password.generateOTP()));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
  }

  @override
  Widget build(BuildContext context) {
    final password = Provider.of<PasswordModel>(context);
    final homeScreen = Provider.of<HomeScreen>(context);
    final selected = homeScreen.selectedPasswordIds.contains(password.id);
    final anySelected = homeScreen.selectedPasswordIds.length >= 1;
    final shown = homeScreen.shownPasswordIds.contains(password.id);

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
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Text(
                  (password.service != null
                          ? password.service.substring(0, 1)
                          : password.account.substring(0, 1))
                      .toUpperCase(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white, // FIXME: should use theme
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
          : const Text('••••••'),
      trailing: shown ? _trailingWidget(context, password) : null,
    );
  }

  Widget _title(password) {
    if (password.service != null) {
      return Row(
        children: [
          Text(password.service),
          const SizedBox(
            width: 5,
          ),
          Text(
            '(${password.account})',
            style: const TextStyle(color: Colors.grey), // FIXME: Theme
          ),
        ],
      );
    } else {
      return Text(password.account);
    }
  }
}

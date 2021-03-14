import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import '../../../redux/app_actions.dart';
import '../../../redux/app_state.dart';
import '../../../models/password.dart';
import '../../../providers/global_timer.dart';
import './circular_time_remaining_indicator.dart';

class PasswordTile extends StatelessWidget {
  final Password password;
  final bool isSelected;
  final bool anySelected;
  final bool isShown;

  PasswordTile({
    @required this.password,
    @required this.isSelected,
    @required this.anySelected,
    @required this.isShown,
  });

  Widget _trailingWidget(BuildContext context, Password password) {
    if (password.timeBased) {
      if (!isShown) {
        return null;
      }

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
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        onPressed: () async {
          StoreProvider.of<AppState>(context)
            ..dispatch(IncreasePasswordCounter(
              password: password,
            ))
            ..dispatch(ToggleDisplayPassword(password, true));
        },
      );
    }
  }

  void _copyToClipboard(BuildContext context, Password password) async {
    await Clipboard.setData(ClipboardData(text: await password.generateOTP()));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (anySelected) {
          StoreProvider.of<AppState>(context)
              .dispatch(ToggleSelectPassword(password));
        } else {
          if (!isShown) {
            _copyToClipboard(context, password);
          }

          StoreProvider.of<AppState>(context)
              .dispatch(ToggleDisplayPassword(password));
        }
      },
      onLongPress: () {
        if (Platform.isIOS) {
          HapticFeedback.selectionClick();
        }

        StoreProvider.of<AppState>(context)
            .dispatch(ToggleSelectPassword(password));
      },
      selected: isSelected,
      selectedTileColor: Theme.of(context).selectedRowColor,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isSelected
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Text(
                  (password.service != null && password.service.length > 0
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
      subtitle: isShown
          ? Consumer<GlobalTimer>(
              builder: (_ctx, timer, _child) {
                return FutureBuilder(
                  future: password.generateOTP(),
                  builder: (_ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('');
                    }

                    return Text(snapshot.data,
                        style: Theme.of(context).textTheme.headline5);
                  },
                );
              },
            )
          : const Text('●●●●●●'),
      trailing: _trailingWidget(context, password),
    );
  }

  Widget _title(password) {
    if (password.service != null && password.service.length > 0) {
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

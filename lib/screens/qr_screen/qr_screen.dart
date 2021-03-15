import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/password.dart';
import '../../redux/app_state.dart';
import './qr_screen_view_model.dart';

class QRScreen extends StatefulWidget {
  QRScreen({Key key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final _pageController = PageController(initialPage: 0);
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export as QR'),
      ),
      body: StoreConnector<AppState, QRScreenViewModel>(
        converter: QRScreenViewModel.fromStore,
        builder: (context, vm) => Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: vm.selectedPasswords.length,
              itemBuilder: (context, index) {
                final password = vm.selectedPasswords[index];
                final uri = _generateUri(password);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: uri));

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Copied to clipboard!')));
                          },
                          child: QrImage(
                            data: uri,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _title(password),
                    ),
                  ],
                );
              },
            ),
            if (vm.selectedPasswords.length > 1)
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                child: DotsIndicator(
                  dotsCount: vm.selectedPasswords.length,
                  position: _currentPage.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Theme.of(context).primaryColor,
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _title(Password password) {
    if (password.hasService) {
      return Text(
        '${password.service} (${password.account})',
        style: Theme.of(context).textTheme.headline6,
      );
    } else {
      return Text(
        password.account,
        style: Theme.of(context).textTheme.headline6,
      );
    }
  }

  String _generateUri(Password password) {
    Map<String, String> queryParameters = {
      'secret': password.secret,
      'digits': password.length.toString(),
      'algorithm': password.algorithmString,
    };

    if (password.timeBased) {
      queryParameters['period'] = password.period.toString();
    } else {
      queryParameters['counter'] = password.counter.toString();
    }

    return Uri(
      scheme: 'otpauth',
      host: password.timeBased ? 'totp' : 'hotp',
      path: ([
        password.hasService ? Uri.encodeComponent(password.service) : null,
        Uri.encodeComponent(password.account),
      ]..remove(null))
          .join(':'),
      queryParameters: queryParameters,
    ).toString();
  }
}

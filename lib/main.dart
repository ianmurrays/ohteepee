import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/passwords.dart';
import './screens/home.dart';

void main() {
  runApp(OhTeePee());
}

class OhTeePee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_ctx) => Passwords(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Home(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/global_timer.dart';
import './providers/passwords.dart';
import './screens/home.dart';

void main() {
  runApp(OhTeePee());
}

class OhTeePee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalTimer>(create: (_ctx) => GlobalTimer()),
        ChangeNotifierProvider<Passwords>(create: (_ctx) => Passwords()),
      ],
      child: MaterialApp(
        title: 'Oh Tee Pee',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Home(),
      ),
    );
  }
}

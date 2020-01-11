import 'package:flutter/material.dart';
import 'package:ohteepee/screens/home.dart';
import 'package:ohteepee/storage/sqlite.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Provider(
        create: (_) async {
          final sqlite = Sqlite();

          await sqlite.setupDatabase();

          return sqlite;
        },
        child: Home(),
      ),
    );
  }
}

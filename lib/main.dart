import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import './providers/home_screen.dart';
import './providers/global_timer.dart';
import './storage/database.dart';
import './screens/home.dart';

void main() async {
  await _unlockRefreshRate();

  runApp(OhTeePee());
}

// From https://github.com/bnxm/shared/blob/master/shared/lib/utils/android_refreshrate_unlocker.dart
Future<void> _unlockRefreshRate() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final current = await FlutterDisplayMode.current;
    final modes = await FlutterDisplayMode.supported;

    DisplayMode bestMode = current;

    for (final mode in modes) {
      final isFaster = mode.refreshRate > bestMode.refreshRate;
      final isSameResolution =
          mode.width == bestMode.width && mode.height == bestMode.height;

      if (isFaster && isSameResolution) {
        bestMode = mode;
      }
    }

    FlutterDisplayMode.setMode(bestMode);
  } catch (e) {
    print(e);
  }
}

class OhTeePee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeScreen>(create: (_ctx) => HomeScreen()),
        ChangeNotifierProvider<GlobalTimer>(create: (_ctx) => GlobalTimer()),
        Provider(
          create: (_ctx) => Database(),
          dispose: (_ctx, Database db) => db.close(),
        ),
      ],
      child: MaterialApp(
        title: 'Oh Tee Pee',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey[800],
          selectedRowColor: Colors.blueGrey[50],
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.blueGrey[800],
            ),
            helperStyle: TextStyle(
              color: Colors.blueGrey[800],
            ),
            hintStyle: TextStyle(
              color: Colors.blueGrey[800],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.blueGrey[800],
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.blueGrey[800],
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.red[900],
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.red[900],
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blueGrey,
          backgroundColor: Colors.grey[850],
          dialogBackgroundColor: Colors.grey[850],
          scaffoldBackgroundColor: Colors.grey[850],
          textTheme: ThemeData.dark().textTheme,
          accentColor: Colors.blueGrey[300],
          selectedRowColor: Colors.grey[900],
          hintColor: Colors.white,
          canvasColor: Colors.grey[850],
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.grey[300],
            ),
            helperStyle: TextStyle(
              color: Colors.grey[300],
            ),
            hintStyle: TextStyle(
              color: Colors.grey[300],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey[300],
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey[300],
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.red[900],
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.red[900],
              ),
            ),
          ),
        ),
        home: Home(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import './providers/home_screen.dart';
import './providers/global_timer.dart';
import './providers/passwords.dart';
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
        ChangeNotifierProvider<Passwords>(create: (_ctx) => Passwords()),
      ],
      child: MaterialApp(
        title: 'Oh Tee Pee',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey[800],
          selectedRowColor: Colors.blueGrey[50],
        ),
        home: Home(),
      ),
    );
  }
}

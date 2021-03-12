import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import './ohteepee.dart';

void main() async {
  await _unlockRefreshRate();

  runApp(App());
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

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OhTeePee();
  }
}

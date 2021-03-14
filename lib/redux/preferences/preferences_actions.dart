import 'package:flutter/foundation.dart';

class LoadPreferences {}

class OnPreferencesLoaded {
  final bool copyToClipboard;

  const OnPreferencesLoaded({@required this.copyToClipboard});
}

class ToggleCopyToClipboard {
  final bool copyToClipboard;

  ToggleCopyToClipboard([bool copyToClipboard])
      : copyToClipboard = copyToClipboard ?? null;
}

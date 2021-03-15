class LoadPreferences {}

class OnPreferencesLoaded {
  final bool copyToClipboard;
  final bool hidePasswords;

  const OnPreferencesLoaded({
    this.copyToClipboard,
    this.hidePasswords,
  });
}

class ToggleCopyToClipboard {
  final bool copyToClipboard;

  ToggleCopyToClipboard([bool copyToClipboard])
      : copyToClipboard = copyToClipboard ?? null;
}

class ToggleHidePasswords {
  final bool hidePasswords;

  ToggleHidePasswords([bool hidePasswords])
      : hidePasswords = hidePasswords ?? null;
}

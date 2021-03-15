import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';

part 'settings_view_model.g.dart';

abstract class SettingsViewModel
    implements Built<SettingsViewModel, SettingsViewModelBuilder> {
  bool get copyToClipboard;

  bool get hidePasswords;

  SettingsViewModel._();

  factory SettingsViewModel([void Function(SettingsViewModelBuilder) updates]) =
      _$SettingsViewModel;

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
        (b) => b
      ..copyToClipboard = store.state.preferences.copyToClipboard
      ..hidePasswords = store.state.preferences.hidePasswords);
  }
}

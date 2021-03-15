import 'package:built_value/built_value.dart';

part 'preferences_state.g.dart';

abstract class PreferencesState
    implements Built<PreferencesState, PreferencesStateBuilder> {
  bool get copyToClipboard;

  bool get hidePasswords;

  PreferencesState._();

  factory PreferencesState([void Function(PreferencesStateBuilder) updates]) =
      _$PreferencesState;

  factory PreferencesState.init() =>
      PreferencesState((b) => b
    ..copyToClipboard = false
    ..hidePasswords = true);
}

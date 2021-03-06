// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PreferencesState extends PreferencesState {
  @override
  final bool copyToClipboard;
  @override
  final bool hidePasswords;

  factory _$PreferencesState(
          [void Function(PreferencesStateBuilder) updates]) =>
      (new PreferencesStateBuilder()..update(updates)).build();

  _$PreferencesState._({this.copyToClipboard, this.hidePasswords}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        copyToClipboard, 'PreferencesState', 'copyToClipboard');
    BuiltValueNullFieldError.checkNotNull(
        hidePasswords, 'PreferencesState', 'hidePasswords');
  }

  @override
  PreferencesState rebuild(void Function(PreferencesStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreferencesStateBuilder toBuilder() =>
      new PreferencesStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreferencesState &&
        copyToClipboard == other.copyToClipboard &&
        hidePasswords == other.hidePasswords;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, copyToClipboard.hashCode), hidePasswords.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreferencesState')
          ..add('copyToClipboard', copyToClipboard)
          ..add('hidePasswords', hidePasswords))
        .toString();
  }
}

class PreferencesStateBuilder
    implements Builder<PreferencesState, PreferencesStateBuilder> {
  _$PreferencesState _$v;

  bool _copyToClipboard;
  bool get copyToClipboard => _$this._copyToClipboard;
  set copyToClipboard(bool copyToClipboard) =>
      _$this._copyToClipboard = copyToClipboard;

  bool _hidePasswords;
  bool get hidePasswords => _$this._hidePasswords;
  set hidePasswords(bool hidePasswords) =>
      _$this._hidePasswords = hidePasswords;

  PreferencesStateBuilder();

  PreferencesStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _copyToClipboard = $v.copyToClipboard;
      _hidePasswords = $v.hidePasswords;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreferencesState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PreferencesState;
  }

  @override
  void update(void Function(PreferencesStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreferencesState build() {
    final _$result = _$v ??
        new _$PreferencesState._(
            copyToClipboard: BuiltValueNullFieldError.checkNotNull(
                copyToClipboard, 'PreferencesState', 'copyToClipboard'),
            hidePasswords: BuiltValueNullFieldError.checkNotNull(
                hidePasswords, 'PreferencesState', 'hidePasswords'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

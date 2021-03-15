// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettingsViewModel extends SettingsViewModel {
  @override
  final bool copyToClipboard;
  @override
  final bool hidePasswords;

  factory _$SettingsViewModel(
          [void Function(SettingsViewModelBuilder) updates]) =>
      (new SettingsViewModelBuilder()..update(updates)).build();

  _$SettingsViewModel._({this.copyToClipboard, this.hidePasswords})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        copyToClipboard, 'SettingsViewModel', 'copyToClipboard');
    BuiltValueNullFieldError.checkNotNull(
        hidePasswords, 'SettingsViewModel', 'hidePasswords');
  }

  @override
  SettingsViewModel rebuild(void Function(SettingsViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsViewModelBuilder toBuilder() =>
      new SettingsViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsViewModel &&
        copyToClipboard == other.copyToClipboard &&
        hidePasswords == other.hidePasswords;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, copyToClipboard.hashCode), hidePasswords.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsViewModel')
          ..add('copyToClipboard', copyToClipboard)
          ..add('hidePasswords', hidePasswords))
        .toString();
  }
}

class SettingsViewModelBuilder
    implements Builder<SettingsViewModel, SettingsViewModelBuilder> {
  _$SettingsViewModel _$v;

  bool _copyToClipboard;
  bool get copyToClipboard => _$this._copyToClipboard;
  set copyToClipboard(bool copyToClipboard) =>
      _$this._copyToClipboard = copyToClipboard;

  bool _hidePasswords;
  bool get hidePasswords => _$this._hidePasswords;
  set hidePasswords(bool hidePasswords) =>
      _$this._hidePasswords = hidePasswords;

  SettingsViewModelBuilder();

  SettingsViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _copyToClipboard = $v.copyToClipboard;
      _hidePasswords = $v.hidePasswords;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SettingsViewModel;
  }

  @override
  void update(void Function(SettingsViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsViewModel build() {
    final _$result = _$v ??
        new _$SettingsViewModel._(
            copyToClipboard: BuiltValueNullFieldError.checkNotNull(
                copyToClipboard, 'SettingsViewModel', 'copyToClipboard'),
            hidePasswords: BuiltValueNullFieldError.checkNotNull(
                hidePasswords, 'SettingsViewModel', 'hidePasswords'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passwords_list_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PasswordsListViewModel extends PasswordsListViewModel {
  @override
  final BuiltList<Password> passwords;
  @override
  final BuiltSet<Password> selectedPasswords;
  @override
  final BuiltSet<Password> shownPasswords;

  factory _$PasswordsListViewModel(
          [void Function(PasswordsListViewModelBuilder) updates]) =>
      (new PasswordsListViewModelBuilder()..update(updates)).build();

  _$PasswordsListViewModel._(
      {this.passwords, this.selectedPasswords, this.shownPasswords})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        passwords, 'PasswordsListViewModel', 'passwords');
    BuiltValueNullFieldError.checkNotNull(
        selectedPasswords, 'PasswordsListViewModel', 'selectedPasswords');
    BuiltValueNullFieldError.checkNotNull(
        shownPasswords, 'PasswordsListViewModel', 'shownPasswords');
  }

  @override
  PasswordsListViewModel rebuild(
          void Function(PasswordsListViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordsListViewModelBuilder toBuilder() =>
      new PasswordsListViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PasswordsListViewModel &&
        passwords == other.passwords &&
        selectedPasswords == other.selectedPasswords &&
        shownPasswords == other.shownPasswords;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, passwords.hashCode), selectedPasswords.hashCode),
        shownPasswords.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PasswordsListViewModel')
          ..add('passwords', passwords)
          ..add('selectedPasswords', selectedPasswords)
          ..add('shownPasswords', shownPasswords))
        .toString();
  }
}

class PasswordsListViewModelBuilder
    implements Builder<PasswordsListViewModel, PasswordsListViewModelBuilder> {
  _$PasswordsListViewModel _$v;

  ListBuilder<Password> _passwords;
  ListBuilder<Password> get passwords =>
      _$this._passwords ??= new ListBuilder<Password>();
  set passwords(ListBuilder<Password> passwords) =>
      _$this._passwords = passwords;

  SetBuilder<Password> _selectedPasswords;
  SetBuilder<Password> get selectedPasswords =>
      _$this._selectedPasswords ??= new SetBuilder<Password>();
  set selectedPasswords(SetBuilder<Password> selectedPasswords) =>
      _$this._selectedPasswords = selectedPasswords;

  SetBuilder<Password> _shownPasswords;
  SetBuilder<Password> get shownPasswords =>
      _$this._shownPasswords ??= new SetBuilder<Password>();
  set shownPasswords(SetBuilder<Password> shownPasswords) =>
      _$this._shownPasswords = shownPasswords;

  PasswordsListViewModelBuilder();

  PasswordsListViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _passwords = $v.passwords.toBuilder();
      _selectedPasswords = $v.selectedPasswords.toBuilder();
      _shownPasswords = $v.shownPasswords.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PasswordsListViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PasswordsListViewModel;
  }

  @override
  void update(void Function(PasswordsListViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PasswordsListViewModel build() {
    _$PasswordsListViewModel _$result;
    try {
      _$result = _$v ??
          new _$PasswordsListViewModel._(
              passwords: passwords.build(),
              selectedPasswords: selectedPasswords.build(),
              shownPasswords: shownPasswords.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'passwords';
        passwords.build();
        _$failedField = 'selectedPasswords';
        selectedPasswords.build();
        _$failedField = 'shownPasswords';
        shownPasswords.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PasswordsListViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

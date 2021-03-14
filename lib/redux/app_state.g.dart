// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final bool startingUp;
  @override
  final BuiltSet<int> selectedPasswordIds;
  @override
  final BuiltSet<int> shownPasswordIds;
  @override
  final bool loadingPasswords;
  @override
  final BuiltList<Password> passwords;
  @override
  final PreferencesState preferences;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.startingUp,
      this.selectedPasswordIds,
      this.shownPasswordIds,
      this.loadingPasswords,
      this.passwords,
      this.preferences})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(startingUp, 'AppState', 'startingUp');
    BuiltValueNullFieldError.checkNotNull(
        selectedPasswordIds, 'AppState', 'selectedPasswordIds');
    BuiltValueNullFieldError.checkNotNull(
        shownPasswordIds, 'AppState', 'shownPasswordIds');
    BuiltValueNullFieldError.checkNotNull(
        loadingPasswords, 'AppState', 'loadingPasswords');
    BuiltValueNullFieldError.checkNotNull(passwords, 'AppState', 'passwords');
    BuiltValueNullFieldError.checkNotNull(
        preferences, 'AppState', 'preferences');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        startingUp == other.startingUp &&
        selectedPasswordIds == other.selectedPasswordIds &&
        shownPasswordIds == other.shownPasswordIds &&
        loadingPasswords == other.loadingPasswords &&
        passwords == other.passwords &&
        preferences == other.preferences;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc(0, startingUp.hashCode),
                        selectedPasswordIds.hashCode),
                    shownPasswordIds.hashCode),
                loadingPasswords.hashCode),
            passwords.hashCode),
        preferences.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('startingUp', startingUp)
          ..add('selectedPasswordIds', selectedPasswordIds)
          ..add('shownPasswordIds', shownPasswordIds)
          ..add('loadingPasswords', loadingPasswords)
          ..add('passwords', passwords)
          ..add('preferences', preferences))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  bool _startingUp;
  bool get startingUp => _$this._startingUp;
  set startingUp(bool startingUp) => _$this._startingUp = startingUp;

  SetBuilder<int> _selectedPasswordIds;
  SetBuilder<int> get selectedPasswordIds =>
      _$this._selectedPasswordIds ??= new SetBuilder<int>();
  set selectedPasswordIds(SetBuilder<int> selectedPasswordIds) =>
      _$this._selectedPasswordIds = selectedPasswordIds;

  SetBuilder<int> _shownPasswordIds;
  SetBuilder<int> get shownPasswordIds =>
      _$this._shownPasswordIds ??= new SetBuilder<int>();
  set shownPasswordIds(SetBuilder<int> shownPasswordIds) =>
      _$this._shownPasswordIds = shownPasswordIds;

  bool _loadingPasswords;
  bool get loadingPasswords => _$this._loadingPasswords;
  set loadingPasswords(bool loadingPasswords) =>
      _$this._loadingPasswords = loadingPasswords;

  ListBuilder<Password> _passwords;
  ListBuilder<Password> get passwords =>
      _$this._passwords ??= new ListBuilder<Password>();
  set passwords(ListBuilder<Password> passwords) =>
      _$this._passwords = passwords;

  PreferencesStateBuilder _preferences;
  PreferencesStateBuilder get preferences =>
      _$this._preferences ??= new PreferencesStateBuilder();
  set preferences(PreferencesStateBuilder preferences) =>
      _$this._preferences = preferences;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startingUp = $v.startingUp;
      _selectedPasswordIds = $v.selectedPasswordIds.toBuilder();
      _shownPasswordIds = $v.shownPasswordIds.toBuilder();
      _loadingPasswords = $v.loadingPasswords;
      _passwords = $v.passwords.toBuilder();
      _preferences = $v.preferences.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              startingUp: BuiltValueNullFieldError.checkNotNull(
                  startingUp, 'AppState', 'startingUp'),
              selectedPasswordIds: selectedPasswordIds.build(),
              shownPasswordIds: shownPasswordIds.build(),
              loadingPasswords: BuiltValueNullFieldError.checkNotNull(
                  loadingPasswords, 'AppState', 'loadingPasswords'),
              passwords: passwords.build(),
              preferences: preferences.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'selectedPasswordIds';
        selectedPasswordIds.build();
        _$failedField = 'shownPasswordIds';
        shownPasswordIds.build();

        _$failedField = 'passwords';
        passwords.build();
        _$failedField = 'preferences';
        preferences.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

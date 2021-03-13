// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeScreenViewModel extends HomeScreenViewModel {
  @override
  final bool showEditButton;
  @override
  final Password selectedPassword;
  @override
  final bool showDeleteButton;
  @override
  final bool showFab;
  @override
  final bool isLoading;

  factory _$HomeScreenViewModel(
          [void Function(HomeScreenViewModelBuilder) updates]) =>
      (new HomeScreenViewModelBuilder()..update(updates)).build();

  _$HomeScreenViewModel._(
      {this.showEditButton,
      this.selectedPassword,
      this.showDeleteButton,
      this.showFab,
      this.isLoading})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        showEditButton, 'HomeScreenViewModel', 'showEditButton');
    BuiltValueNullFieldError.checkNotNull(
        showDeleteButton, 'HomeScreenViewModel', 'showDeleteButton');
    BuiltValueNullFieldError.checkNotNull(
        showFab, 'HomeScreenViewModel', 'showFab');
    BuiltValueNullFieldError.checkNotNull(
        isLoading, 'HomeScreenViewModel', 'isLoading');
  }

  @override
  HomeScreenViewModel rebuild(
          void Function(HomeScreenViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeScreenViewModelBuilder toBuilder() =>
      new HomeScreenViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeScreenViewModel &&
        showEditButton == other.showEditButton &&
        selectedPassword == other.selectedPassword &&
        showDeleteButton == other.showDeleteButton &&
        showFab == other.showFab &&
        isLoading == other.isLoading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, showEditButton.hashCode), selectedPassword.hashCode),
                showDeleteButton.hashCode),
            showFab.hashCode),
        isLoading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeScreenViewModel')
          ..add('showEditButton', showEditButton)
          ..add('selectedPassword', selectedPassword)
          ..add('showDeleteButton', showDeleteButton)
          ..add('showFab', showFab)
          ..add('isLoading', isLoading))
        .toString();
  }
}

class HomeScreenViewModelBuilder
    implements Builder<HomeScreenViewModel, HomeScreenViewModelBuilder> {
  _$HomeScreenViewModel _$v;

  bool _showEditButton;
  bool get showEditButton => _$this._showEditButton;
  set showEditButton(bool showEditButton) =>
      _$this._showEditButton = showEditButton;

  PasswordBuilder _selectedPassword;
  PasswordBuilder get selectedPassword =>
      _$this._selectedPassword ??= new PasswordBuilder();
  set selectedPassword(PasswordBuilder selectedPassword) =>
      _$this._selectedPassword = selectedPassword;

  bool _showDeleteButton;
  bool get showDeleteButton => _$this._showDeleteButton;
  set showDeleteButton(bool showDeleteButton) =>
      _$this._showDeleteButton = showDeleteButton;

  bool _showFab;
  bool get showFab => _$this._showFab;
  set showFab(bool showFab) => _$this._showFab = showFab;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  HomeScreenViewModelBuilder();

  HomeScreenViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _showEditButton = $v.showEditButton;
      _selectedPassword = $v.selectedPassword?.toBuilder();
      _showDeleteButton = $v.showDeleteButton;
      _showFab = $v.showFab;
      _isLoading = $v.isLoading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeScreenViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeScreenViewModel;
  }

  @override
  void update(void Function(HomeScreenViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeScreenViewModel build() {
    _$HomeScreenViewModel _$result;
    try {
      _$result = _$v ??
          new _$HomeScreenViewModel._(
              showEditButton: BuiltValueNullFieldError.checkNotNull(
                  showEditButton, 'HomeScreenViewModel', 'showEditButton'),
              selectedPassword: _selectedPassword?.build(),
              showDeleteButton: BuiltValueNullFieldError.checkNotNull(
                  showDeleteButton, 'HomeScreenViewModel', 'showDeleteButton'),
              showFab: BuiltValueNullFieldError.checkNotNull(
                  showFab, 'HomeScreenViewModel', 'showFab'),
              isLoading: BuiltValueNullFieldError.checkNotNull(
                  isLoading, 'HomeScreenViewModel', 'isLoading'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'selectedPassword';
        _selectedPassword?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomeScreenViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

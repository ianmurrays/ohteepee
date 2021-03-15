// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_screen_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QRScreenViewModel extends QRScreenViewModel {
  @override
  final BuiltList<Password> selectedPasswords;

  factory _$QRScreenViewModel(
          [void Function(QRScreenViewModelBuilder) updates]) =>
      (new QRScreenViewModelBuilder()..update(updates)).build();

  _$QRScreenViewModel._({this.selectedPasswords}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        selectedPasswords, 'QRScreenViewModel', 'selectedPasswords');
  }

  @override
  QRScreenViewModel rebuild(void Function(QRScreenViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QRScreenViewModelBuilder toBuilder() =>
      new QRScreenViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QRScreenViewModel &&
        selectedPasswords == other.selectedPasswords;
  }

  @override
  int get hashCode {
    return $jf($jc(0, selectedPasswords.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QRScreenViewModel')
          ..add('selectedPasswords', selectedPasswords))
        .toString();
  }
}

class QRScreenViewModelBuilder
    implements Builder<QRScreenViewModel, QRScreenViewModelBuilder> {
  _$QRScreenViewModel _$v;

  ListBuilder<Password> _selectedPasswords;
  ListBuilder<Password> get selectedPasswords =>
      _$this._selectedPasswords ??= new ListBuilder<Password>();
  set selectedPasswords(ListBuilder<Password> selectedPasswords) =>
      _$this._selectedPasswords = selectedPasswords;

  QRScreenViewModelBuilder();

  QRScreenViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _selectedPasswords = $v.selectedPasswords.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QRScreenViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QRScreenViewModel;
  }

  @override
  void update(void Function(QRScreenViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QRScreenViewModel build() {
    _$QRScreenViewModel _$result;
    try {
      _$result = _$v ??
          new _$QRScreenViewModel._(
              selectedPasswords: selectedPasswords.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'selectedPasswords';
        selectedPasswords.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QRScreenViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

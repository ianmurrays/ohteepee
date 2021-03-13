// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Password extends Password {
  @override
  final int id;
  @override
  final String service;
  @override
  final String account;
  @override
  final String secret;
  @override
  final int length;
  @override
  final int period;
  @override
  final Algorithm algorithm;
  @override
  final bool timeBased;
  @override
  final int counter;

  factory _$Password([void Function(PasswordBuilder) updates]) =>
      (new PasswordBuilder()..update(updates)).build();

  _$Password._(
      {this.id,
      this.service,
      this.account,
      this.secret,
      this.length,
      this.period,
      this.algorithm,
      this.timeBased,
      this.counter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(account, 'Password', 'account');
    BuiltValueNullFieldError.checkNotNull(secret, 'Password', 'secret');
    BuiltValueNullFieldError.checkNotNull(length, 'Password', 'length');
    BuiltValueNullFieldError.checkNotNull(algorithm, 'Password', 'algorithm');
    BuiltValueNullFieldError.checkNotNull(timeBased, 'Password', 'timeBased');
  }

  @override
  Password rebuild(void Function(PasswordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordBuilder toBuilder() => new PasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Password &&
        id == other.id &&
        service == other.service &&
        account == other.account &&
        secret == other.secret &&
        length == other.length &&
        period == other.period &&
        algorithm == other.algorithm &&
        timeBased == other.timeBased &&
        counter == other.counter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), service.hashCode),
                                account.hashCode),
                            secret.hashCode),
                        length.hashCode),
                    period.hashCode),
                algorithm.hashCode),
            timeBased.hashCode),
        counter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Password')
          ..add('id', id)
          ..add('service', service)
          ..add('account', account)
          ..add('secret', secret)
          ..add('length', length)
          ..add('period', period)
          ..add('algorithm', algorithm)
          ..add('timeBased', timeBased)
          ..add('counter', counter))
        .toString();
  }
}

class PasswordBuilder implements Builder<Password, PasswordBuilder> {
  _$Password _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _service;
  String get service => _$this._service;
  set service(String service) => _$this._service = service;

  String _account;
  String get account => _$this._account;
  set account(String account) => _$this._account = account;

  String _secret;
  String get secret => _$this._secret;
  set secret(String secret) => _$this._secret = secret;

  int _length;
  int get length => _$this._length;
  set length(int length) => _$this._length = length;

  int _period;
  int get period => _$this._period;
  set period(int period) => _$this._period = period;

  Algorithm _algorithm;
  Algorithm get algorithm => _$this._algorithm;
  set algorithm(Algorithm algorithm) => _$this._algorithm = algorithm;

  bool _timeBased;
  bool get timeBased => _$this._timeBased;
  set timeBased(bool timeBased) => _$this._timeBased = timeBased;

  int _counter;
  int get counter => _$this._counter;
  set counter(int counter) => _$this._counter = counter;

  PasswordBuilder();

  PasswordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _service = $v.service;
      _account = $v.account;
      _secret = $v.secret;
      _length = $v.length;
      _period = $v.period;
      _algorithm = $v.algorithm;
      _timeBased = $v.timeBased;
      _counter = $v.counter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Password other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Password;
  }

  @override
  void update(void Function(PasswordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Password build() {
    final _$result = _$v ??
        new _$Password._(
            id: id,
            service: service,
            account: BuiltValueNullFieldError.checkNotNull(
                account, 'Password', 'account'),
            secret: BuiltValueNullFieldError.checkNotNull(
                secret, 'Password', 'secret'),
            length: BuiltValueNullFieldError.checkNotNull(
                length, 'Password', 'length'),
            period: period,
            algorithm: BuiltValueNullFieldError.checkNotNull(
                algorithm, 'Password', 'algorithm'),
            timeBased: BuiltValueNullFieldError.checkNotNull(
                timeBased, 'Password', 'timeBased'),
            counter: counter);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

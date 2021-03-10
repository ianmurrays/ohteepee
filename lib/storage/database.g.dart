// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Password extends DataClass implements Insertable<Password> {
  final int id;
  final String service;
  final String account;
  final int length;
  final int period;
  final Algorithm algorithm;
  final bool timeBased;
  final int counter;
  Password(
      {@required this.id,
      this.service,
      @required this.account,
      this.length,
      this.period,
      @required this.algorithm,
      @required this.timeBased,
      this.counter});
  factory Password.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Password(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      service:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}service']),
      account:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}account']),
      length: intType.mapFromDatabaseResponse(data['${effectivePrefix}length']),
      period: intType.mapFromDatabaseResponse(data['${effectivePrefix}period']),
      algorithm: $PasswordsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}algorithm'])),
      timeBased: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}time_based']),
      counter:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}counter']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || service != null) {
      map['service'] = Variable<String>(service);
    }
    if (!nullToAbsent || account != null) {
      map['account'] = Variable<String>(account);
    }
    if (!nullToAbsent || length != null) {
      map['length'] = Variable<int>(length);
    }
    if (!nullToAbsent || period != null) {
      map['period'] = Variable<int>(period);
    }
    if (!nullToAbsent || algorithm != null) {
      final converter = $PasswordsTable.$converter0;
      map['algorithm'] = Variable<int>(converter.mapToSql(algorithm));
    }
    if (!nullToAbsent || timeBased != null) {
      map['time_based'] = Variable<bool>(timeBased);
    }
    if (!nullToAbsent || counter != null) {
      map['counter'] = Variable<int>(counter);
    }
    return map;
  }

  PasswordsCompanion toCompanion(bool nullToAbsent) {
    return PasswordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      service: service == null && nullToAbsent
          ? const Value.absent()
          : Value(service),
      account: account == null && nullToAbsent
          ? const Value.absent()
          : Value(account),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
      period:
          period == null && nullToAbsent ? const Value.absent() : Value(period),
      algorithm: algorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(algorithm),
      timeBased: timeBased == null && nullToAbsent
          ? const Value.absent()
          : Value(timeBased),
      counter: counter == null && nullToAbsent
          ? const Value.absent()
          : Value(counter),
    );
  }

  factory Password.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Password(
      id: serializer.fromJson<int>(json['id']),
      service: serializer.fromJson<String>(json['service']),
      account: serializer.fromJson<String>(json['account']),
      length: serializer.fromJson<int>(json['length']),
      period: serializer.fromJson<int>(json['period']),
      algorithm: serializer.fromJson<Algorithm>(json['algorithm']),
      timeBased: serializer.fromJson<bool>(json['timeBased']),
      counter: serializer.fromJson<int>(json['counter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'service': serializer.toJson<String>(service),
      'account': serializer.toJson<String>(account),
      'length': serializer.toJson<int>(length),
      'period': serializer.toJson<int>(period),
      'algorithm': serializer.toJson<Algorithm>(algorithm),
      'timeBased': serializer.toJson<bool>(timeBased),
      'counter': serializer.toJson<int>(counter),
    };
  }

  Password copyWith(
          {int id,
          String service,
          String account,
          int length,
          int period,
          Algorithm algorithm,
          bool timeBased,
          int counter}) =>
      Password(
        id: id ?? this.id,
        service: service ?? this.service,
        account: account ?? this.account,
        length: length ?? this.length,
        period: period ?? this.period,
        algorithm: algorithm ?? this.algorithm,
        timeBased: timeBased ?? this.timeBased,
        counter: counter ?? this.counter,
      );
  @override
  String toString() {
    return (StringBuffer('Password(')
          ..write('id: $id, ')
          ..write('service: $service, ')
          ..write('account: $account, ')
          ..write('length: $length, ')
          ..write('period: $period, ')
          ..write('algorithm: $algorithm, ')
          ..write('timeBased: $timeBased, ')
          ..write('counter: $counter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          service.hashCode,
          $mrjc(
              account.hashCode,
              $mrjc(
                  length.hashCode,
                  $mrjc(
                      period.hashCode,
                      $mrjc(algorithm.hashCode,
                          $mrjc(timeBased.hashCode, counter.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Password &&
          other.id == this.id &&
          other.service == this.service &&
          other.account == this.account &&
          other.length == this.length &&
          other.period == this.period &&
          other.algorithm == this.algorithm &&
          other.timeBased == this.timeBased &&
          other.counter == this.counter);
}

class PasswordsCompanion extends UpdateCompanion<Password> {
  final Value<int> id;
  final Value<String> service;
  final Value<String> account;
  final Value<int> length;
  final Value<int> period;
  final Value<Algorithm> algorithm;
  final Value<bool> timeBased;
  final Value<int> counter;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.service = const Value.absent(),
    this.account = const Value.absent(),
    this.length = const Value.absent(),
    this.period = const Value.absent(),
    this.algorithm = const Value.absent(),
    this.timeBased = const Value.absent(),
    this.counter = const Value.absent(),
  });
  PasswordsCompanion.insert({
    this.id = const Value.absent(),
    this.service = const Value.absent(),
    @required String account,
    this.length = const Value.absent(),
    this.period = const Value.absent(),
    @required Algorithm algorithm,
    this.timeBased = const Value.absent(),
    this.counter = const Value.absent(),
  })  : account = Value(account),
        algorithm = Value(algorithm);
  static Insertable<Password> custom({
    Expression<int> id,
    Expression<String> service,
    Expression<String> account,
    Expression<int> length,
    Expression<int> period,
    Expression<int> algorithm,
    Expression<bool> timeBased,
    Expression<int> counter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (service != null) 'service': service,
      if (account != null) 'account': account,
      if (length != null) 'length': length,
      if (period != null) 'period': period,
      if (algorithm != null) 'algorithm': algorithm,
      if (timeBased != null) 'time_based': timeBased,
      if (counter != null) 'counter': counter,
    });
  }

  PasswordsCompanion copyWith(
      {Value<int> id,
      Value<String> service,
      Value<String> account,
      Value<int> length,
      Value<int> period,
      Value<Algorithm> algorithm,
      Value<bool> timeBased,
      Value<int> counter}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      service: service ?? this.service,
      account: account ?? this.account,
      length: length ?? this.length,
      period: period ?? this.period,
      algorithm: algorithm ?? this.algorithm,
      timeBased: timeBased ?? this.timeBased,
      counter: counter ?? this.counter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (account.present) {
      map['account'] = Variable<String>(account.value);
    }
    if (length.present) {
      map['length'] = Variable<int>(length.value);
    }
    if (period.present) {
      map['period'] = Variable<int>(period.value);
    }
    if (algorithm.present) {
      final converter = $PasswordsTable.$converter0;
      map['algorithm'] = Variable<int>(converter.mapToSql(algorithm.value));
    }
    if (timeBased.present) {
      map['time_based'] = Variable<bool>(timeBased.value);
    }
    if (counter.present) {
      map['counter'] = Variable<int>(counter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PasswordsCompanion(')
          ..write('id: $id, ')
          ..write('service: $service, ')
          ..write('account: $account, ')
          ..write('length: $length, ')
          ..write('period: $period, ')
          ..write('algorithm: $algorithm, ')
          ..write('timeBased: $timeBased, ')
          ..write('counter: $counter')
          ..write(')'))
        .toString();
  }
}

class $PasswordsTable extends Passwords
    with TableInfo<$PasswordsTable, Password> {
  final GeneratedDatabase _db;
  final String _alias;
  $PasswordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _serviceMeta = const VerificationMeta('service');
  GeneratedTextColumn _service;
  @override
  GeneratedTextColumn get service => _service ??= _constructService();
  GeneratedTextColumn _constructService() {
    return GeneratedTextColumn(
      'service',
      $tableName,
      true,
    );
  }

  final VerificationMeta _accountMeta = const VerificationMeta('account');
  GeneratedTextColumn _account;
  @override
  GeneratedTextColumn get account => _account ??= _constructAccount();
  GeneratedTextColumn _constructAccount() {
    return GeneratedTextColumn('account', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _lengthMeta = const VerificationMeta('length');
  GeneratedIntColumn _length;
  @override
  GeneratedIntColumn get length => _length ??= _constructLength();
  GeneratedIntColumn _constructLength() {
    return GeneratedIntColumn(
      'length',
      $tableName,
      true,
    );
  }

  final VerificationMeta _periodMeta = const VerificationMeta('period');
  GeneratedIntColumn _period;
  @override
  GeneratedIntColumn get period => _period ??= _constructPeriod();
  GeneratedIntColumn _constructPeriod() {
    return GeneratedIntColumn(
      'period',
      $tableName,
      true,
    );
  }

  final VerificationMeta _algorithmMeta = const VerificationMeta('algorithm');
  GeneratedIntColumn _algorithm;
  @override
  GeneratedIntColumn get algorithm => _algorithm ??= _constructAlgorithm();
  GeneratedIntColumn _constructAlgorithm() {
    return GeneratedIntColumn(
      'algorithm',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeBasedMeta = const VerificationMeta('timeBased');
  GeneratedBoolColumn _timeBased;
  @override
  GeneratedBoolColumn get timeBased => _timeBased ??= _constructTimeBased();
  GeneratedBoolColumn _constructTimeBased() {
    return GeneratedBoolColumn('time_based', $tableName, false,
        defaultValue: const Constant(true));
  }

  final VerificationMeta _counterMeta = const VerificationMeta('counter');
  GeneratedIntColumn _counter;
  @override
  GeneratedIntColumn get counter => _counter ??= _constructCounter();
  GeneratedIntColumn _constructCounter() {
    return GeneratedIntColumn(
      'counter',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, service, account, length, period, algorithm, timeBased, counter];
  @override
  $PasswordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'passwords';
  @override
  final String actualTableName = 'passwords';
  @override
  VerificationContext validateIntegrity(Insertable<Password> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('service')) {
      context.handle(_serviceMeta,
          service.isAcceptableOrUnknown(data['service'], _serviceMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account'], _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length'], _lengthMeta));
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period'], _periodMeta));
    }
    context.handle(_algorithmMeta, const VerificationResult.success());
    if (data.containsKey('time_based')) {
      context.handle(_timeBasedMeta,
          timeBased.isAcceptableOrUnknown(data['time_based'], _timeBasedMeta));
    }
    if (data.containsKey('counter')) {
      context.handle(_counterMeta,
          counter.isAcceptableOrUnknown(data['counter'], _counterMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Password map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Password.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PasswordsTable createAlias(String alias) {
    return $PasswordsTable(_db, alias);
  }

  static TypeConverter<Algorithm, int> $converter0 = const AlgorithmConverter();
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PasswordsTable _passwords;
  $PasswordsTable get passwords => _passwords ??= $PasswordsTable(this);
  PasswordDao _passwordDao;
  PasswordDao get passwordDao => _passwordDao ??= PasswordDao(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [passwords];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PasswordDaoMixin on DatabaseAccessor<Database> {
  $PasswordsTable get passwords => attachedDatabase.passwords;
}

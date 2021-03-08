import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

enum Algorithm {
  SHA1,
  SHA256,
  SHA512,
}

class AlgorithmConverter extends TypeConverter<Algorithm, int> {
  const AlgorithmConverter();

  @override
  Algorithm mapToDart(int fromDb) {
    return Algorithm.values[fromDb];
  }

  @override
  int mapToSql(Algorithm value) {
    return value.index;
  }
}

class Passwords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get service => text().nullable()();
  TextColumn get account => text().withLength(min: 1, max: 100)();
  TextColumn get secret => text().withLength(min: 1)();
  IntColumn get length => integer().nullable()();
  IntColumn get period => integer().nullable()();
  IntColumn get algorithm => integer().map(const AlgorithmConverter())();
  BoolColumn get timeBased => boolean().withDefault(const Constant(true))();
  IntColumn get counter => integer().nullable()();
}

@UseMoor(tables: [Passwords], daos: [PasswordDao])
class Database extends _$Database {
  Database()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            // Good for debugging - prints SQL in the console
            logStatements: true,
          ),
        );

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Passwords])
class PasswordDao extends DatabaseAccessor<Database> with _$PasswordDaoMixin {
  PasswordDao(Database attachedDatabase) : super(attachedDatabase);

  Stream<List<Password>> watchAll() {
    return (select(passwords)..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .watch();
  }

  Future<Password> findById(int id) {
    return (select(passwords)..where((t) => t.id.equals(id))).getSingle();
  }

  Future insertPassword(PasswordsCompanion password) {
    return into(passwords).insert(password);
  }

  Future updatePassword(Password password) {
    return update(passwords).replace(password);
  }

  Future deletePassword(Password password) {
    return delete(passwords).delete(password);
  }

  Future deletePasswordIds(List<int> ids) {
    return (delete(passwords)..where((t) => t.id.isIn(ids))).go();
  }
}

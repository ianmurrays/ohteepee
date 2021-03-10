part of 'database.dart';

class Passwords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get service => text().nullable()();
  TextColumn get account => text().withLength(min: 1, max: 100)();
  IntColumn get length => integer().nullable()();
  IntColumn get period => integer().nullable()();
  IntColumn get algorithm => integer().map(const AlgorithmConverter())();
  BoolColumn get timeBased => boolean().withDefault(const Constant(true))();
  IntColumn get counter => integer().nullable()();
}

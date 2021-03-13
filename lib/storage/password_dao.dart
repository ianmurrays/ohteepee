part of 'database.dart';

@UseDao(tables: [Passwords])
class PasswordDao extends DatabaseAccessor<Database> with _$PasswordDaoMixin {
  PasswordDao(Database attachedDatabase) : super(attachedDatabase);

  Future<List<PasswordRow>> selectAll() async {
    return (select(passwords)..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  Future<PasswordRow> findById(int id) {
    return (select(passwords)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> insertPassword(PasswordsCompanion password) {
    return into(passwords).insert(password);
  }

  Future updatePassword(int id, PasswordsCompanion password) {
    return (update(passwords)..where((t) => t.id.equals(id))).write(password);
  }

  Future deletePassword(int id) {
    return (delete(passwords)..where((t) => t.id.equals(id))).go();
  }

  Future deletePasswordIds(List<int> ids) {
    return (delete(passwords)..where((t) => t.id.isIn(ids))).go();
  }
}

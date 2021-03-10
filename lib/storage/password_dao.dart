part of 'database.dart';

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

  Future<int> insertPassword(PasswordsCompanion password) {
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

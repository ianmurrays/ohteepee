import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'algorithm_converter.dart';
part 'passwords.dart';
part 'password_dao.dart';
part 'database.g.dart';

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

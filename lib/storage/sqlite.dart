import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite {
  static final Sqlite _sqlite = Sqlite._internal();

  factory Sqlite() {
    return _sqlite;
  }

  // --------------------------

  Future<Database> db;

  Sqlite._internal();

  Future setupDatabase() async {
    this.db = openDatabase(
      join(await getDatabasesPath(), 'ohteepee.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
            create table one_time_passwords (
              id integer primary key,
              service text,
              account text,
              secret text,
              timeBased boolean default true
            )
          '''
        );
      },
      version: 1
    );

    return this.db;
  }
}

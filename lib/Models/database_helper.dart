import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static late final Database _db;

  static Future<void> init() async {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      String path = '${await getDatabasesPath()}/todo.db';
      try {
        _db = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            print('database created');
            await _db.execute('''
              CREATE TABLE UserConfig (configName TEXT PRIMARY KEY NOT NULL, value TEXT NOT NULL);
              CREATE TABLE Tasks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                note TEXT DEFAULT(''),
                color TEXT DEFAULT 'red',
                date CHAR(12),
                endDate CHAR(12),
                startTime TEXT,
                endTime TEXT,
                repeate TEXT DEFAULT 'none',
                rimender INT DEFAULT 0,
                isFinished BOOLEAN DEFAULT 0,
              );''');
          },
          onOpen: (db) {},
        );
      } on Exception catch (e) {
        print(e);
      }
      await createTables();
  }

  static Future<void> createTables() async {
    ;
  }
}

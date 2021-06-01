import 'package:path/path.dart';
import 'package:rgstr/registrations/registration_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper();

  static const databaseName = 'test.db';
  static final DatabaseHelper instance = DatabaseHelper();

  Future<Database> get database async {
    return await initializeDatabase();
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName), version: 3, onCreate: (Database db, int version) async {
      const CREATE_TABLE_REGISTRATIONS =
          "CREATE TABLE IF NOT EXISTS ${Registration.TABLE} (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, imei TEXT, first_name TEXT, last_name TEXT, dob TEXT, passport TEXT, email TEXT, picture TEXT, os_name TEXT, os_version TEXT, longitude REAL, latitude REAL)";
      await db.execute(CREATE_TABLE_REGISTRATIONS);
    });
  }
}

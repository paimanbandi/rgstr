import 'package:rgstr/registrations/registration_model.dart';
import 'package:rgstr/db.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationDao {
  RegistrationDao();

  Future<Database> get database async {
    Database db = await DatabaseHelper().database;
    return db;
  }

  Future<int> register(Registration pRegistration) async {
    final db = await database;
    int res = 0;
    await db.transaction((txn) async {
      var registration = Registration(
          id: pRegistration.id,
          imei: pRegistration.imei,
          firstName: pRegistration.firstName,
          lastName: pRegistration.lastName,
          dob: pRegistration.dob,
          passport: pRegistration.passport,
          email: pRegistration.email,
          picture: pRegistration.picture,
          osName: pRegistration.osName,
          osVersion: pRegistration.osVersion,
          longitude: pRegistration.longitude,
          latitude: pRegistration.latitude);

      res = await txn.insert(Registration.TABLE, registration.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      print("res");
      print(res);
      return res;
    });
    return res;
  }
}

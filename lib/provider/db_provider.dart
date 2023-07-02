import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/employee_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Employee('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'strFullName TEXT,'
          'strEmployeeType TEXT,'
          'strFromDate TEXT,'
          'strToDate TEXT'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(Employee newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db!.insert('Employee', newEmployee.toJson());

    return res;
  }

  // Insert employee on database
  Future<int> insertEmployee(Employee newEmployee) async {
    final db = await database;
    final res = await db!.insert(
      'Employee',
      newEmployee.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  // Insert employee on database
  Future<int> updateEmployee(Employee newEmployee) async {
    final db = await database;

    int updateCount = await db!.update('Employee', newEmployee.toJson(),
        where: 'id = ?', whereArgs: [newEmployee.id]);
    return updateCount;
  }

  // Insert employee on database
  Future<int> checkEmployeeExist(String strFullName) async {
    final db = await database;
    int intCount = Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) FROM Employee WHERE strFullName = ?', [strFullName]))!;
    return intCount;
  }

  // Delete employee by id
  Future<int> deleteEmployeesByID(int id) async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Employee where id = $id');

    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Employee');

    return res;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM Employee");

    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

    return list;
  }
}

//add Expenses
import 'package:limkokwing_resource_department/models/Admin.dart';
import 'package:limkokwing_resource_department/services/database.dart';

Future<Admin> addAdmin(Admin admin) async {
  final db = await ResourcesDatabase.instance.database;
  final id = await db.insert(tableAdmin, admin.toJson());
  return admin.copy(id: id);
}

//read Expense
Future<Admin> getAdmin(int id) async {
  final db = await ResourcesDatabase.instance.database;
  final maps = await db.query(tableAdmin,
      columns: AdminFields.values,
      where: '${AdminFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Admin.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Admin>> getAdminList() async {
  final db = await ResourcesDatabase.instance.database;
  final result = await db.query(tableAdmin);
  return result.map((json) => Admin.fromJson(json)).toList();
}

//update Question
Future<int> updateAdmin(Admin admin) async {
  final db = await ResourcesDatabase.instance.database;

  return db.update(tableAdmin, admin.toJson(),
      where: '${AdminFields.id} = ?', whereArgs: [admin.id]);
}

Future<int> deleteAdmin(int id) async {
  final db = await ResourcesDatabase.instance.database;
  return await db
      .delete(tableAdmin, where: '${AdminFields.id} = ?', whereArgs: [id]);
}

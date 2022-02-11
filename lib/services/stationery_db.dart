//add Expenses
import 'package:limkokwing_resource_department/models/Stationery.dart';
import 'package:limkokwing_resource_department/services/database.dart';

Future<Stationery> addStationery(Stationery stationery) async {
  final db = await ResourcesDatabase.instance.database;
  final id = await db.insert(tableStationery, stationery.toJson());
  return stationery.copy(id: id);
}

//read Expense
Future<Stationery> getStationery(int id) async {
  final db = await ResourcesDatabase.instance.database;
  final maps = await db.query(tableStationery,
      columns: StationeryFields.values,
      where: '${StationeryFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Stationery.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Stationery>> getStationeryList() async {
  final db = await ResourcesDatabase.instance.database;
  final result = await db.query(tableStationery);
  return result.map((json) => Stationery.fromJson(json)).toList();
}

//update Question
Future<int> updateStationery(Stationery stationery) async {
  final db = await ResourcesDatabase.instance.database;

  return db.update(tableStationery, stationery.toJson(),
      where: '${StationeryFields.id} = ?', whereArgs: [stationery.id]);
}

Future<int> deleteStationery(int id) async {
  final db = await ResourcesDatabase.instance.database;
  return await db.delete(tableStationery,
      where: '${StationeryFields.id} = ?', whereArgs: [id]);
}

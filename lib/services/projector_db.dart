//add Expenses
import 'package:limkokwing_resource_department/models/Projector.dart';
import 'package:limkokwing_resource_department/services/database.dart';

Future<Projector> addAnswers(Projector projector) async {
  final db = await ResourcesDatabase.instance.database;
  final id = await db.insert(tableProjector, projector.toJson());
  return projector.copy(id: id);
}

//read Expense
Future<Projector> getAnswers(int id) async {
  final db = await ResourcesDatabase.instance.database;
  final maps = await db.query(tableProjector,
      columns: ProjectorFields.values,
      where: '${ProjectorFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Projector.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Projector>> getProjectorList() async {
  final db = await ResourcesDatabase.instance.database;
  final result = await db.query(tableProjector);
  return result.map((json) => Projector.fromJson(json)).toList();
}

//update Question
Future<int> updateBudget(Projector projector) async {
  final db = await ResourcesDatabase.instance.database;

  return db.update(tableProjector, projector.toJson(),
      where: '${ProjectorFields.id} = ?', whereArgs: [projector.id]);
}

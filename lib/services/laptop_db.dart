//add Expenses
import 'package:limkokwing_resource_department/models/Laptop.dart';
import 'package:limkokwing_resource_department/services/database.dart';

Future<Laptop> addAnswers(Laptop laptop) async {
  final db = await ResourcesDatabase.instance.database;
  final id = await db.insert(tableLaptop, laptop.toJson());
  return laptop.copy(id: id);
}

//read Expense
Future<Laptop> getAnswers(int id) async {
  final db = await ResourcesDatabase.instance.database;
  final maps = await db.query(tableLaptop,
      columns: LaptopFields.values,
      where: '${LaptopFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Laptop.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Laptop>> getAnswersList() async {
  final db = await ResourcesDatabase.instance.database;
  final result = await db.query(tableLaptop);
  return result.map((json) => Laptop.fromJson(json)).toList();
}

//update Question
Future<int> updateBudget(Laptop question) async {
  final db = await ResourcesDatabase.instance.database;

  return db.update(tableLaptop, question.toJson(),
      where: '${LaptopFields.id} = ?', whereArgs: [question.id]);
}

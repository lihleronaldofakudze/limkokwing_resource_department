//add Expenses
import 'package:limkokwing_resource_department/models/Venue.dart';
import 'package:limkokwing_resource_department/services/database.dart';

Future<Venue> addVenue(Venue venue) async {
  final db = await ResourcesDatabase.instance.database;
  final id = await db.insert(tableVenues, venue.toJson());
  return venue.copy(id: id);
}

//read Expense
Future<Venue> getVenue(int id) async {
  final db = await ResourcesDatabase.instance.database;
  final maps = await db.query(tableVenues,
      columns: VenueFields.values,
      where: '${VenueFields.id} = ?',
      whereArgs: [id]);

  if (maps.isNotEmpty) {
    return Venue.fromJson(maps.first);
  } else {
    throw Exception('ID $id is not available');
  }
}

//read All Expenses
Future<List<Venue>> getVenueList() async {
  final db = await ResourcesDatabase.instance.database;
  final result = await db.query(tableVenues);
  return result.map((json) => Venue.fromJson(json)).toList();
}

//update Question
Future<int> updateVenue(Venue venue) async {
  final db = await ResourcesDatabase.instance.database;

  return db.update(tableVenues, venue.toJson(),
      where: '${VenueFields.id} = ?', whereArgs: [venue.id]);
}

Future<int> deleteVenue(int id) async {
  final db = await ResourcesDatabase.instance.database;
  return await db
      .delete(tableVenues, where: '${VenueFields.id} = ?', whereArgs: [id]);
}

import 'package:limkokwing_resource_department/models/Laptop.dart';
import 'package:limkokwing_resource_department/models/Projector.dart';
import 'package:limkokwing_resource_department/models/Stationery.dart';
import 'package:limkokwing_resource_department/models/Venue.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ResourcesDatabase {
  //create an instance
  static final ResourcesDatabase instance = ResourcesDatabase._init();

  static Database? _database;

  ResourcesDatabase._init();

  //initialize a database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('resources.db');
    return _database!;
  }

  //save database to database paths
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create database
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INT NOT NULL';

    //create table Projector
    await db.execute('CREATE TABLE $tableProjector ('
        '${ProjectorFields.id} $idType,'
        '${ProjectorFields.name} $textType,'
        '${ProjectorFields.serialNumber} $textType,'
        '${ProjectorFields.status} $textType,'
        '${ProjectorFields.department} $textType,'
        '${ProjectorFields.dateTime} $textType'
        ')');

    //create table Laptop
    await db.execute('CREATE TABLE $tableLaptop ('
        '${LaptopFields.id} $idType,'
        '${LaptopFields.name} $textType,'
        '${LaptopFields.serialNumber} $textType,'
        '${LaptopFields.status} $textType,'
        '${LaptopFields.department} $textType,'
        '${LaptopFields.dateTime} $textType'
        ')');

    //create table Stationery
    await db.execute('CREATE TABLE $tableStationery ('
        '${StationeryFields.id} $idType,'
        '${StationeryFields.name} $textType,'
        '${StationeryFields.quantity} $intType,'
        '${StationeryFields.employee} $textType,'
        '${StationeryFields.dateTime} $textType'
        ')');

    //create table Stationery
    await db.execute('CREATE TABLE $tableVenues ('
        '${VenueFields.id} $idType,'
        '${VenueFields.name} $textType,'
        '${VenueFields.bookedBy} $textType,'
        '${VenueFields.nameOfEvent} $intType,'
        '${VenueFields.status} $textType,'
        '${VenueFields.dateTime} $textType'
        ')');
  }

  //close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

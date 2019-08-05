import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:noteremind/models/note_object.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = "noteTable";
  String colId = "id";
  String colTitle = "title";
  String colDes = "des";
  String colDate = "priority";
  String colPriority = "date";

  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory _dir = await getApplicationDocumentsDirectory();
    String path = _dir.path + "/notes.db";

    var _noteDb = await openDatabase(path, version: 1, onCreate: createDB);

    return _noteDb;
  }

  void createDB(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDes TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');

    return result;
  }

  Future<int> insert(Notes note) async {
    Database db = await this.database;
    
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Notes note) async {
    Database db = await this.database;

    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;

    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $noteTable');

    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Notes>> getNoteList() async {
    var mapList = await getNoteMapList();

    int count = mapList.length;
    List<Notes> noteList = List<Notes>();

    for (int i = 0; i < count; i++) {
      noteList.add(Notes.fromMapObject(mapList[i]));
    }

    return noteList;
  }
}
import 'dart:io';
import 'package:contact_app/Contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class Databasehelper {

  static Databasehelper _databasehelper;
  static Database _database;

  String noteTable= 'note_table';
  String colId='id';
  String colName='name';
  String colEmail='email';
  String colNumber='number';

  Databasehelper._createINstance();

  factory Databasehelper() {

      if(_databasehelper==null) {
        _databasehelper = Databasehelper._createINstance();
      }
      return _databasehelper;
  }

  Future<Database> get database async {
    if(_database ==null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database>initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path+ "notes.db";

    var notesDatabase = await openDatabase(path,version: 1, onCreate: _createdb);
    return notesDatabase;
  }

  void _createdb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colEmail TEXT ,$colNumber TEXT)");
  }

  Future<List<Map<String, dynamic >>> getNoteMapList() async {
    Database db =await this.database;
    var result= await db.query(noteTable,orderBy: '$colName ASC');
    return result;
  }

  Future<int> insertNote(Contact note) async {
    Database db= await this.database;
    var result=await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Contact note) async {
    var db= await this.database;
    var result= await db.update(noteTable,note.toMap(), where: "$colId = ?",whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNode(int id) async {
    var db= await this.database;
    int result= await db.rawDelete("DELETE FROM $noteTable WHERE $colId = $id");
    return result;
  }


   Future<int> getCount() async {
    Database db= await this.database;
    List<Map<String, dynamic>> x= await db.rawQuery("SELECT COUNT (*) FROM $noteTable");
    int result= Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Contact>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Contact> noteList= List<Contact>();
    for(int i=0; i<count; i++) {
      noteList.add(Contact.fromMapObject(noteMapList[i]));
    }

    return noteList;

  }
}
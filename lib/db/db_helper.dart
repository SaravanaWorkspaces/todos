import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todos/model/todo.dart';

class DatabaseHelper {
  String intTypeAutoInc = "INTEGER PRIMARY KEY AUTOINCREMENT";
  String typeText = "TEXT";
  String typeNumber = "NUMBER";

  String TABLE_TODO = "_todo";
  Database? _database;

  DatabaseHelper();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getDatabasesPath(); // Returns relative path of DB directory/Document directory
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE_TODO (${TodoFields.ID} $intTypeAutoInc, ${TodoFields.TODO} $typeText,' +
            '${TodoFields.DESC} $typeText, ${TodoFields.TODAY} $typeText, ${TodoFields.CREATEDTS} $typeNumber, ${TodoFields.MODIFIEDTS} $typeNumber)');
  }

  Future<void> insertTodo(Todo todo) async {
    try {
      final db = await database;
      await db.insert(TABLE_TODO, todo.toMap());
    } catch (e) {
      throw Exception("Insert Todo failed");
    }
  }
}

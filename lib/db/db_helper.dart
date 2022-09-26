import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:todos/model/todo.dart';

class DatabaseHelper {
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
    final path = p.join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    
    await db.execute(
        'CREATE TABLE $TABLE_TODO (${TodoFields.ID}, ${TodoFields.TODO}, ${TodoFields.DESC}, ${TodoFields.TODAY}, ${TodoFields.CREATEDTS}, ${TodoFields.MODIFIEDTS})');
  }

  Future<int?> insertTodo(Todo todo) async {
    var todoObj = {
      "todo"        : todo.todo,
      "desc"        : todo.desc,
      "today"       : todo.today,
      "createdTs"   : todo.createdTs,
      "modifiedTs"  : todo.modifiedTs,
    };
    
    final rowId = await _database?.insert(TABLE_TODO, todoObj);
    return rowId;
  }
}

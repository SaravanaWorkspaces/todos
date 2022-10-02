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
      db.close();
    } catch (e) {
      throw Exception("Insert Todo failed");
    }
  }

  Future<List<Todo>> fetchTodoList() async {
    const orderBy = '${TodoFields.MODIFIEDTS} DESC';
    final db = await database;
    final results = await db.query(TABLE_TODO, orderBy: orderBy);
    if (results.isEmpty) {
      return [];
    } else {
      return results.map((item) => Todo.fromMap(item)).toList();
    }
  }

  Future<Todo> getTodoById(int id) async {
    String whereString = '${TodoFields.ID} = ?';
    final db = await database;
    final results = await db.query(TABLE_TODO, where: whereString, whereArgs: [id]);
    if(results.isEmpty) {
      throw Exception("TODO not exists");
    } else {
      return Todo.fromMap(results.first);
    }
  }

  Future<int> updateTodo(int id, int modifiedTs, [String? todo, String? desc, bool? isToday]) async {
    String whereString = '${TodoFields.ID} = ?';
    Map<String, dynamic> row = {};
    if(todo != null) row[TodoFields.TODO] = todo;
    if(desc != null) row[TodoFields.DESC] = desc;
    if(isToday != null) row[TodoFields.TODAY] = isToday.toString();
    row[TodoFields.MODIFIEDTS] = modifiedTs;

    try {
      final db = await database;
      int updateCount = await db.update(TABLE_TODO, row, where: whereString, whereArgs: [id]);
      db.close();
      return updateCount;
    } catch(e) {
      throw Exception(e.toString());
    }
  }
}

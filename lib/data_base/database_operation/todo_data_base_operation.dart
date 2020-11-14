import 'package:test_app/data_base/todo_info.dart';
import 'package:test_app/model/data_base_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class TodoDatabaseOperation{
  Database database;

 Future<void> userInfoDatBase() async {
    database =
    await openDatabase(join(await getDatabasesPath(), "user_info_db.db"),
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE user_info(user_id INTEGER PRIMARY KEY, email TEXT, password TEXT)');
          await db.execute(
              'CREATE TABLE user_todo_info(todo_id INTEGER PRIMARY KEY , title TEXT, description TEXT, created_time TEXT,user_id INTEGER)');
        }, version: 1);
  }

  Future<int> insertTodoInfo(DataBaseModel model) async {
    Database db = database;
    int id= await db.insert(
      model.userTable(),
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  return id;
  }

  Future<List<TodoInfo>> getAllPost(String table, int userId) async {
    Database db = database;
    final List<Map<String, dynamic>> values =
    await db.query(table, where: "user_id=?", whereArgs: [userId]);
    List<TodoInfo> models = List<TodoInfo>();
    for (var item in values) models.add(TodoInfo.fromMap(item));
    return models;
  }

  Future<void> updateTodoInfo(DataBaseModel model, int userId, int todoId) async {
   print("the first args is :: $userId");
   print("the first args is :: $todoId");

   Database db = database;
    await db.update(
      model.userTable(),
      model.toMap(),
      where: 'user_id=? AND todo_id=?',
      whereArgs: [userId, todoId],
    );
  }
}
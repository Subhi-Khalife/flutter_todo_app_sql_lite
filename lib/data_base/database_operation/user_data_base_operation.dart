import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app/data_base/todo_info.dart';
import 'package:test_app/data_base/user_info.dart';
import 'package:test_app/model/data_base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataBaseOperation {
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


  Future<int> insertUser(DataBaseModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Database db = database;
    int id = await db.insert(
      model.userTable(),
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("The id is :: $id");
    sharedPreferences.setInt("user_id", id);
    sharedPreferences.setBool("loginDone", true);
    return id;
  }

  Future<bool> checkUserContain(String table, String email) async {
    await userInfoDatBase();
    Database db = database;
    final List<Map<String, dynamic>> values =
        await db.query(table, where: "email=?", whereArgs: [email]);
    List<DataBaseModel> models = List<DataBaseModel>();
    for (var item in values) models.add(UserInfo.fromMap(item));
    if (models.isEmpty)
      return false;
    else
      return true;
  }

  Future<int> checkUserLogin(String table, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await userInfoDatBase();
    Database db = database;
    final List<Map<String, dynamic>> values = await db.query(table,
        where: "email=? AND password=?", whereArgs: [email, password]);
    List<DataBaseModel> models = List<DataBaseModel>();
    for (var item in values) models.add(UserInfo.fromMap(item));
    if (models.isEmpty)
      return 0;
    else {
      print("The id is :: ${models[0].getId()}");
      sharedPreferences.setInt("user_id", models[0].getId());
      sharedPreferences.setBool("loginDone", true);
      return models[0].getId();
    }
  }

}

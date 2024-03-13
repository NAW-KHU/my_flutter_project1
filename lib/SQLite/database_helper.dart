import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_login_sqflite/JasonModels/user_data.dart';

class DatabaseHelper {
  final databaseName = "notes.db";

  //Create user table into sqlite db

  String users =
      """CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT,usrName TEXT UNIQUE,usrPassword TEXT)""";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
    });
  }

  //Login Method
  Future<bool> login(Users user) async {
    final Database db = await initDB();

    var userInput = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (userInput.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //SignUp method
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert('users', user.toMap());
  }
}

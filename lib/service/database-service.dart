import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflitte_demo/model/todo.dart';
import 'package:sqflitte_demo/model/user.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  _initDb() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)");
        await db.execute(
            "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, title TEXT, description TEXT, isCompleted INTEGER, FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE)");
      }
    );
  }

  Future<int> insertNewUser(User user) async {
    var dbClient = await database;
    return await dbClient.insert('users', user.toMap());
  }

  Future<User?> validateUser(String email, String password) async {
    var dbClient = await database;
    var res = await dbClient.query('users',
        where: "email = ? AND password = ?", whereArgs: [email, password]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<User?> getUserById(int id) async {
    var dbClient = await database;
    List<Map<String, dynamic>> res = await dbClient.query('users', where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    }
    return null; // Return null if no user found
  }

  Future<int> insertTodo(ToDo todo) async {
    var dbClient = await database;
    return await dbClient.insert('todos', todo.toMap());
  }

  Future<List<ToDo>> getTodos(int userId) async {
    var dbClient = await database;
    List<Map<String, dynamic>> res = await dbClient.query('todos', where: "userId = ?", whereArgs: [userId]);
    return res.map((todoMap) => ToDo.fromMap(todoMap)).toList();
  }

}
import 'package:food_recipe/features/home/data/model/food_recipe_search_response.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE results(
        id INTEGER PRIMARY KEY,
        recipeId INTEGER,
        title TEXT,
        image TEXT,
        imageType TEXT
      )
    ''');
  }

  Future<int> insertResult(Result results) async {
    Database db = await instance.database;
    return await db.insert('results', results.toMap());
  }

  Future<void> insertResults(List<Result> results) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    for (var result in results) {
      batch.insert('results', result.toMap());
    }
    await batch.commit();
  }

  Future<bool> isIdAlreadyInserted(int id) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> result = await db.query(
    'results',
    where: 'id = ?',
    whereArgs: [id],
  );
  return result.isNotEmpty;
}


  Future<List<Result>> getResults() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('results');
    return List.generate(maps.length, (i) {
      return Result.fromMap(maps[i]);
    });
  }

  Future<int> deleteResultById(int id) async {
    Database db = await instance.database;
    return await db.delete('results', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllResults() async {
    Database db = await instance.database;
    return await db.delete('results');
  }
}

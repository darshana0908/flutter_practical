import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'aa.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 8, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "register" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "mobile" Text  NOT NULL,
      "user_name" TEXT NOT NULL,
       "password" INTEGER  NOT NULL
    


  )
 ''');

    await db.execute('''
  CREATE TABLE "gamelist" (
    "id" INTEGER  NOT NULL PRIMARY KEY  ,
      "thumbnail" TEXT NOT NULL,
       "title" TEXT NOT NULL,
      
      "genre" TEXT NOT NULL,
      "platform" TEXT NOT NULL,
      "developer" TEXT NOT NULL,
      "release_date" TEXT NOT NULL,
      "short_description" TEXT NOT NULL
      
    


  )
 ''');

    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  rawQuery(String sql, List<String> list) {}

  batch() {}

// SELECT
// DELETE
// UPDATE
// INSERT

}

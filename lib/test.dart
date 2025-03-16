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
    String path = join(databasepath, 'wael.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 16, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    await db.execute("ALTER TABLE NOTES ADD COLUMN day TEXT");
    print("onUpgrade =====================================");
  }

  //
  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "note" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "done" boolean NOT NULL DEFAULT(0),
     "Faviority" boolean NOT NULL DEFAULT(0),
    "Datee"   TEXT NOT NULL
  )
 ''');
    batch.execute('''
  CREATE TABLE "Finish" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "Datee" TEXT NOT NULL
  )
 ''');
    await batch.commit();
    print(" onCreate =====================================>");
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

// حذف كامل قاعدة المعطيات
  daleteDataabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.db');
    await deleteDatabase(path);
  }
}

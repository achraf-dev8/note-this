import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? dbVal;

  Future<Database> get db async{
    dbVal ??= await initialDb();
    return dbVal!;
  }

Future<Database> initialDb()async{
  String dbpath = await getDatabasesPath();
  String path = join(dbpath, "note_this.db");
  Database myDb = await openDatabase(path, onCreate: onCreate, version: 1, onUpgrade: onUpgrade);
  return myDb;

}

showData(String sql, List<dynamic> arguments)async{
  Database mydb = await db;
  List<Map> response = await mydb.rawQuery(sql, arguments);
  return response;
}

 insertData(String sql, List<dynamic> arguments) async {
  Database mydb = await db;
  return await mydb.rawInsert(sql, arguments);
}

updateData(String sql, List<dynamic> arguments)async{
  Database mydb = await db;
  int response = await mydb.rawUpdate(sql, arguments);
  return response;
}

deleteData(String sql, List<dynamic> arguments)async{
  Database mydb = await db;
  int response = await mydb.rawDelete(sql, arguments);
  return response;
}

onCreate(Database db, int version) async {
  await db.execute('''
CREATE TABLE "notes" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
  "heading" TEXT NOT NULL, 
  "body" TEXT NOT NULL, 
  "date" TEXT DEFAULT (datetime('now')), 
  "color" INTEGER NOT NULL,
  "pin" INTEGER DEFAULT 0
)
''');

print("Created");

}

onUpgrade(Database db, int oldVersion, int version)async{

}

Future<void> onDelete() async {
  String dbpath = await getDatabasesPath();
  String path = join(dbpath, "note_this.db");
  await deleteDatabase(path);
}

}
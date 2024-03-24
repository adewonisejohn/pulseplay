import 'package:sqflite/sqflite.dart';

class DbTransactions {
  var db;

  Future<bool> isTableInDatabase(var db, String tableName) async {
    final tables = await db.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: [tableName],
    );

    return tables.isNotEmpty;
  }

  Future<void> saveToPlayList(data) async {
    db = await openDatabase('pulseplay.db');
    bool tableExists = await isTableInDatabase(db, 'favorites');
    if (tableExists == false) {
      await db.execute('''
      CREATE TABLE favorites (
        id TEXT PRIMARY KEY,
        title TEXT,
        artist TEXT,
        url TEXT,
        thumbnail TEXT
      )
    ''');
    }

    try {
      await db.transaction((txn) async {
        int id1 = await txn.rawInsert(
          'INSERT INTO favorites(id, title, artist, url, thumbnail) VALUES("${data['id']}", "${data['title']}","${data['artist']}","${data['url']}","${data['thumbnail']}")',
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Future <dynamic> getPlayList() async {
    db = await openDatabase('pulseplay.db');
    try {
      List<Map> result = await db.rawQuery('SELECT * FROM favorites');
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteSongById(String id) async {
    db = await openDatabase('pulseplay.db');
    try {
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM favorites WHERE id = ?', [id]);
      });
      print("song id : ${id} deleted successfully");
    } catch (e) {
      print(e);
    }
  }
}

import 'package:sqflite/sqflite.dart';

late Database db;
Future<void> initialiseDatabase() async {
  db = await openDatabase(
    'CAMERAPP.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE camera (id INTEGER PRIMARY KEY, imagesrc TEXT)');
    },
  );
}

Future<void> addImageToDB(String imageSrc) async {
  await db.rawInsert('INSERT INTO camera(imagesrc) VALUES(?)', [imageSrc]);
}

Future<List<Map<String, dynamic>>> getImageFromDB() async {
  final value = await db.rawQuery('SELECT * FROM camera');
  return value;
}

Future<void> deleteImageFromDB(id) async {
  await db.rawDelete('DELETE FROM camera WHERE id = ?', [id]);
}

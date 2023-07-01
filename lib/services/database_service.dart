import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;
import '../models/favorite_wallpaper_model.dart';

class DatabaseProvider {
  static const String _databaseName = 'wallpaper_app.db';
  static const String _tableName = 'favorite_wallpapers';
  static const String _columnId = 'id';
  static const String _columnImageUrl = 'imageUrl';

  static Future<sqflite.Database> initDatabase() async {
    final databasePath = await sqflite.getDatabasesPath();
    final pathToDatabase = path.join(databasePath, _databaseName);

    return await sqflite.openDatabase(
      pathToDatabase,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY,
            $_columnImageUrl TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertFavoriteWallpaper(FavoriteWallpaper wallpaper) async {
    final database = await initDatabase();
    await database.insert(_tableName, wallpaper.toMap(),
        conflictAlgorithm: sqflite.ConflictAlgorithm.replace);
  }

  static Future<List<FavoriteWallpaper>> getAllFavoriteWallpapers() async {
    final database = await initDatabase();
    final wallpapers = await database.query(_tableName);
    return wallpapers
        .map((map) => FavoriteWallpaper.fromMap(map))
        .toList();
  }

  static Future<void> deleteFavoriteWallpaper(int id) async {
    final database = await initDatabase();
    await database.delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }
}

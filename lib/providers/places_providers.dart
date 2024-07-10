import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabse() async {
  final String dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,address TEXT)');
    },
    version: 1,
  );
  return db;
}

class PlacesNotifire extends StateNotifier<List<Place>> {
  PlacesNotifire() : super(const []);

  Future<void> loadPlaces() async {
    final Database db = await _getDatabse();
    final List<Map<String, Object?>> data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            title: row['title'] as String,
            imageFile: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }

  void addPlaces(String title, File imageFile, PlaceLocation location) async {
    final Directory dir = await syspath.getApplicationDocumentsDirectory();
    final String filename = path.basename(imageFile.path);
    final copyiedImage = await imageFile.copy('${dir.path}/$filename');

    final newPlace =
        Place(title: title, imageFile: copyiedImage, location: location);

    final Database db = await _getDatabse();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.imageFile.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    state = [newPlace, ...state];
  }
}

final placesProviders = StateNotifierProvider<PlacesNotifire, List<Place>>(
  (ref) => PlacesNotifire(),
);

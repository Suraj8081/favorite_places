import 'dart:io';

import 'package:uuid/uuid.dart';

class Place {
  Place({
    required this.title,
    required this.imageFile,
    required this.location,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final File imageFile;
  final PlaceLocation location;
}

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

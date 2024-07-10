import 'package:favorite_places/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(latitude: 37.424, longitude: -122.084, address: ''),
    this.isSelected = true,
  });

  final PlaceLocation location;
  final bool isSelected;

  @override
  State<StatefulWidget> createState() => _MapSatate();
}

class _MapSatate extends State<MapScreen> {
  LatLng? _selectedLocation;

  void savePlace() {
    Navigator.of(context).pop<LatLng>(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelected ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (widget.isSelected)
            IconButton(
              onPressed: savePlace,
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelected
            ? null
            : (latlng) {
                setState(() {
                  _selectedLocation = latlng;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_selectedLocation == null && widget.isSelected)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _selectedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                )
              },
      ),
    );
  }
}

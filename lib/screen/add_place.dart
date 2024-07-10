import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/providers/places_providers.dart';
import 'package:favorite_places/widget/image_input.dart';
import 'package:favorite_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  late TextEditingController titleController;
  File? _imageFile;
  PlaceLocation? _selecetdLocation;

  void _savePlace() {
    final title = titleController.text;

    if (title.isEmpty || _imageFile == null || _selecetdLocation == null) {
      return;
    }

    ref
        .read(placesProviders.notifier)
        .addPlaces(title, _imageFile!, _selecetdLocation!);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLength: 20,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: const InputDecoration(
                    label: Text('Title'), counterText: ''),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(takePicture: (file) {
                _imageFile = file;
              }),
              const SizedBox(
                height: 10,
              ),
              LocationInput(
                onSelectLocation: (location) {
                  _selecetdLocation = location;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: _savePlace,
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

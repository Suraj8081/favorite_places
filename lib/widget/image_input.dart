import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.takePicture});

  final void Function(File file) takePicture;

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickImage == null) {
      return;
    }

    setState(() {
      _selectImage = File(pickImage.path);
    });

    widget.takePicture(_selectImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Click Image'),
    );

    if (_selectImage != null) {
      content = InkWell(
        onTap: _takePicture,
        child: Image.file(
          _selectImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}

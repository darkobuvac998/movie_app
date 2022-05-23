import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  const UserImagePicker({
    required this.imagePickFn,
    Key? key,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage(BuildContext ctx) async {
    showDialog(
      context: ctx,
      builder: (contx) => AlertDialog(
        content: const Text(
          'Choose image source',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(
              ctx,
              ImageSource.camera,
            ),
            child: const Text(
              'Camera',
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              ctx,
              ImageSource.camera,
            ),
            child: const Text(
              'Gallery',
            ),
          ),
        ],
      ),
    ).then((src) async {
      if (src != null) {
        var img = await ImagePicker().pickImage(
          source: src,
          imageQuality: 50,
          maxWidth: 150,
        );

        setState(() {
          _pickedImage = File(img!.path);
        });
        widget.imagePickFn(_pickedImage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null
              ? FileImage(
                  _pickedImage!,
                )
              : null,
        ),
        TextButton.icon(
          onPressed: () => _pickImage(context),
          icon: const Icon(
            Icons.image,
          ),
          label: const Text(
            'Add image',
          ),
        ),
      ],
    );
  }
}

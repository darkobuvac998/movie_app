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

  void _pickImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagePickFn(_pickedImage!);
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
          onPressed: _pickImage,
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

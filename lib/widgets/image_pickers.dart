import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicket extends StatefulWidget {
  @override
  _ImagePicketState createState() => _ImagePicketState();
}



class _ImagePicketState extends State<ImagePicket> {

  File file;
  final picker = ImagePicker();

  Future<void> choosePicture(ImageSource imageSource) async {
    try {
      final object = await picker.getImage(source: imageSource);
      setState(() {
        file = File(object.path);
      });
    } catch (ex) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

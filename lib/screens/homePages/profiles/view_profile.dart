import 'dart:io';

import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  String file;

  ViewProfile({this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຮູບພາບໂປຣຟາຍ'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              file == null ? Container() : Image.network(file),
            ],
          ),
        ),
      ),
    );
  }
}

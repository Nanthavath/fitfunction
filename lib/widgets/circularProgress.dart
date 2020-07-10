import 'package:flutter/material.dart';

class CircularProgress {
  bool isLoading = false;
  showCircularProgress() {
    if (isLoading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

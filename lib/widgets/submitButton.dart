import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final String title;

  const SubmitButton({Key key, this.color, this.onPressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

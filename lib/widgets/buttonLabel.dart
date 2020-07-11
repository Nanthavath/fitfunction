import 'package:flutter/material.dart';

class ButtonLabel extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Icon icon;
  final String title;

  const ButtonLabel(
      {Key key,
      this.color = Colors.orange,
      this.onPressed,
      this.icon,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Column(
        children: <Widget>[
          icon,
          Text(title),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

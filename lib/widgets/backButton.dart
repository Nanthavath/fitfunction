import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const MyBackButton({Key key, this.color=Colors.orange, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: IconButton(
        icon: const BackButtonIcon(),
        color: color,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else {
            Navigator.maybePop(context);
          }
        },
      ),
    );
  }
}

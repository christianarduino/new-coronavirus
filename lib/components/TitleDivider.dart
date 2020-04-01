import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String label;
  final double fontSize;

  const TitleDivider({
    Key key,
    this.label,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

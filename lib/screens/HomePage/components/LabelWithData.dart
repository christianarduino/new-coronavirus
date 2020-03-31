import 'package:flutter/material.dart';

class LabelWithData extends StatelessWidget {
  final String label;
  final String data;

  const LabelWithData({Key key, this.label, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          data,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}

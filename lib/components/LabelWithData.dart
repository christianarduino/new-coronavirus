import 'package:flutter/material.dart';

class LabelWithData extends StatelessWidget {
  final String label;
  final double sizeLabel;
  final String data;
  final double sizeData;

  const LabelWithData(
      {Key key, this.label, this.data, this.sizeLabel, this.sizeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          data,
          style: TextStyle(
            fontSize: sizeData,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: sizeLabel,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}

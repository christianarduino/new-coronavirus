import 'package:flutter/material.dart';

class TileData extends StatelessWidget {
  final double fontSizeLabel;
  final double fontSizeData;
  final int data;
  final String label;

  const TileData(
      {Key key,
      this.data,
      this.fontSizeLabel = 20,
      this.fontSizeData = 18,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: fontSizeLabel,
        ),
      ),
      trailing: Text(
        data.toString(),
        style: TextStyle(
          fontSize: fontSizeData,
        ),
      ),
    );
  }
}

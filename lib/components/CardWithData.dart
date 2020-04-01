import 'package:flutter/material.dart';

import 'LabelWithData.dart';

class CardWithData extends StatelessWidget {
  final double sizeLabel;
  final double sizeData;
  final String newInfected;
  final String dead;
  final String recovered;
  final String title;
  final Function onTap;

  const CardWithData({
    Key key,
    this.sizeLabel,
    this.sizeData,
    this.newInfected,
    this.dead,
    this.recovered,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(bottom: 20),
        elevation: 7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                top: 10.0,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(17.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: LabelWithData(
                      label: "Nuovi infetti",
                      data: newInfected,
                      sizeLabel: sizeLabel,
                      sizeData: sizeData,
                    ),
                  ),
                  Expanded(
                    child: LabelWithData(
                      label: "Deceduti",
                      data: dead,
                      sizeLabel: sizeLabel,
                      sizeData: sizeData,
                    ),
                  ),
                  Expanded(
                    child: LabelWithData(
                      label: "Guariti",
                      data: recovered,
                      sizeLabel: sizeLabel,
                      sizeData: sizeData,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

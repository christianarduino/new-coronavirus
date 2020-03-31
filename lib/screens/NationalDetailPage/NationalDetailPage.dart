import 'package:flutter/material.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/utils/functions.dart';
import 'package:pie_chart/pie_chart.dart';

class NationalDetailPage extends StatelessWidget {
  final National national;

  const NationalDetailPage({Key key, this.national}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Infetti": national.totalInfected.toDouble(),
      "Guariti": national.recovered.toDouble(),
      "Deceduti": national.dead.toDouble(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(dateWithSlash(national.date)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 25,
        ),
        children: <Widget>[
          PieChart(dataMap: dataMap),
        ],
      ),
    );
  }
}

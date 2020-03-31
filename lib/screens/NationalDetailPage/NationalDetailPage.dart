import 'package:flutter/material.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/utils/functions.dart';
import 'package:pie_chart/pie_chart.dart';

class NationalDetailPage extends StatelessWidget {
  final National national;

  const NationalDetailPage({Key key, this.national}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(
      fontSize: 20,
    );
    const TextStyle dataStyle = TextStyle(
      fontSize: 18,
    );

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
          SizedBox(height: 20),
          ListTile(
            title: Text(
              "Totali casi positivi",
              style: titleStyle,
            ),
            trailing: Text(
              national.totalCases.toString(),
              style: dataStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Infetti attuali",
              style: titleStyle,
            ),
            trailing: Text(
              national.totalInfected.toString(),
              style: dataStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Nuovi infetti",
              style: titleStyle,
            ),
            trailing: Text(
              national.newInfected.toString(),
              style: dataStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Deceduti",
              style: titleStyle,
            ),
            trailing: Text(
              national.dead.toString(),
              style: dataStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Guariti",
              style: titleStyle,
            ),
            trailing: Text(
              national.recovered.toString(),
              style: dataStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Tamponi effettuati",
              style: titleStyle,
            ),
            trailing: Text(
              national.swab.toString(),
              style: dataStyle,
            ),
          ),
        ],
      ),
    );
  }
}

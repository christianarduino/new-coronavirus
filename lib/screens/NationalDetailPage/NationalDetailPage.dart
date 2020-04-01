import 'package:flutter/material.dart';
import 'package:new_coronavirus/components/TileData.dart';
import 'package:new_coronavirus/components/TitleDivider.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/utils/functions.dart';
import 'package:pie_chart/pie_chart.dart';

class NationalDetailPage extends StatelessWidget {
  final National national;
  final National prevData;

  const NationalDetailPage({
    Key key,
    this.national,
    this.prevData,
  }) : super(key: key);

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
          TitleDivider(label: "Dati generali"),
          PieChart(dataMap: dataMap),
          SizedBox(height: 20),
          TileData(
            label: "Totali casi positivi",
            data: national.totalCases,
          ),
          TileData(
            label: "Infetti attuali",
            data: national.totalInfected,
          ),
          TileData(
            label: "Deceduti",
            data: national.dead,
          ),
          TileData(
            label: "Guariti",
            data: national.recovered,
          ),
          TileData(
            label: "Tamponi effettuati",
            data: national.swab,
          ),
          Builder(
            builder: (context) {
              if (prevData == null) return SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  TitleDivider(label: "Rispetto a ieri"),
                  TileData(
                    label: "Nuovi infetti",
                    data: national.newInfected,
                  ),
                  TileData(
                    label: "Nuovi deceduti",
                    data: national.dead - prevData.dead,
                  ),
                  TileData(
                    label: "Nuovi guariti",
                    data: national.recovered - prevData.recovered,
                  ),
                  TileData(
                    label: "Tamponi effettuati",
                    data: national.swab - prevData.swab,
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

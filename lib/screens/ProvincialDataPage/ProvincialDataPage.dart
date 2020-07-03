import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/ColumnBuilder.dart';
import 'package:new_coronavirus/components/TitleDivider.dart';
import 'package:new_coronavirus/models/Provincial.dart';
import 'package:new_coronavirus/models/Regional.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:new_coronavirus/screens/MapFullscreenPage/MapFullscreenPage.dart';
import 'package:pie_chart/pie_chart.dart';

class ProvincialDataPage extends StatefulWidget {
  final Regional regional;

  const ProvincialDataPage({Key key, this.regional}) : super(key: key);

  @override
  _ProvincialDataPageState createState() => _ProvincialDataPageState();
}

class _ProvincialDataPageState extends State<ProvincialDataPage> {
  Regional regional;
  CameraPosition initialPosition;
  List<Provincial> provincials = [];
  Map<String, double> provincialPieData = {};
  Map<String, double> regionalPieData = {};

  @override
  void initState() {
    super.initState();
    regional = widget.regional;
    /* initialPosition = CameraPosition(
      target: LatLng(regional.latitude, regional.longitude),
      zoom: 7.2,
      bearing: 10,
    ); */
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(
      fontSize: 18,
    );
    const TextStyle dataStyle = TextStyle(
      fontSize: 16,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dati provinciali - ${widget.regional.name}",
          overflow: TextOverflow.ellipsis,
        ),
        /* actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MapFullscreenPage(
                regional: widget.regional,
              ),
            )),
          ),
        ], */
      ),
      body: StoreConnector<AppState, AppState>(
        onInit: (store) {
          provincials = List.from(store.state.provincialLatest[regional.name]);
          provincials.sort(
            (Provincial a, Provincial b) =>
                b.totalCases.compareTo(a.totalCases),
          );
          provincials.forEach(
            (Provincial provincial) => provincialPieData[provincial.name] =
                provincial.totalCases.toDouble(),
          );
          regionalPieData = {
            "Infetti": regional.totalInfected.toDouble(),
            "Guariti": regional.recovered.toDouble(),
            "Deceduti": regional.dead.toDouble(),
          };
        },
        converter: (store) => store.state,
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            children: <Widget>[
              TitleDivider(label: "Dati generali"),
              PieChart(
                dataMap: regionalPieData,
              ),
              ListTile(
                title: Text(
                  "Totali casi positivi",
                  style: titleStyle,
                ),
                trailing: Text(
                  regional.totalCases.toString(),
                  style: dataStyle,
                ),
              ),
              ListTile(
                title: Text(
                  "Infetti attuali",
                  style: titleStyle,
                ),
                trailing: Text(
                  regional.totalInfected.toString(),
                  style: dataStyle,
                ),
              ),
              ListTile(
                title: Text(
                  "Nuovi infetti",
                  style: titleStyle,
                ),
                trailing: Text(
                  regional.newInfected.toString(),
                  style: dataStyle,
                ),
              ),
              ListTile(
                title: Text(
                  "Deceduti",
                  style: titleStyle,
                ),
                trailing: Text(
                  regional.dead.toString(),
                  style: dataStyle,
                ),
              ),
              ListTile(
                title: Text(
                  "Guariti",
                  style: titleStyle,
                ),
                trailing: Text(
                  regional.recovered.toString(),
                  style: dataStyle,
                ),
              ),
              ListTile(
                title: Text(
                  "Tamponi effettuati",
                  style: titleStyle,
                ),
                trailing: Text(
                  regional.swab.toString(),
                  style: dataStyle,
                ),
              ),
              SizedBox(height: 20),
              TitleDivider(label: "Dati per provincia"),
              PieChart(
                dataMap: provincialPieData,
              ),
              ColumnBuilder(
                itemCount: provincials.length,
                itemBuilder: (_, int i) {
                  Provincial provincial = provincials[i];
                  return ListTile(
                    title: Text(provincial.name),
                    subtitle: Text(provincial.originCode),
                    trailing: Text(
                      provincial.totalCases.toString(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

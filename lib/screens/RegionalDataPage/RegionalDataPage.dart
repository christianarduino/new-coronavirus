import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/CardWithData.dart';
import 'package:new_coronavirus/models/Regional.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:new_coronavirus/utils/functions.dart';

class RegionalDataPage extends StatefulWidget {
  @override
  _RegionalDataPageState createState() => _RegionalDataPageState();
}

class _RegionalDataPageState extends State<RegionalDataPage> {
  List<Regional> renderList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dati regionali"),
      ),
      body: StoreConnector<AppState, List<Regional>>(
        onInit: (store) => renderList = store.state.regionalLatest,
        converter: (store) => store.state.regionalLatest,
        builder: (context, regionalLatest) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelText: "Cerca una regione",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          renderList = regionalLatest
                              .where((Regional regional) =>
                                  RegExp(value).hasMatch(regional.name))
                              .toList();
                        });
                      } else {
                        setState(() {
                          renderList = List.from(regionalLatest);
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: renderList.length,
                    itemBuilder: (_, int i) {
                      Regional regional = renderList[i];
                      return CardWithData(
                        sizeLabel: 17,
                        sizeData: 20,
                        dead: regional.dead.toString(),
                        recovered: regional.recovered.toString(),
                        newInfected: regional.newInfected.toString(),
                        title: "${regional.name} - In data " +
                            dateWithSlash(regional.date),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

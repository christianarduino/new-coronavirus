import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:new_coronavirus/components/LabelWithData.dart';
import 'package:new_coronavirus/screens/NationalDetailPage/NationalDetailPage.dart';
import 'package:new_coronavirus/utils/functions.dart';

class NationalDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double sizeLabel = 17;
    const double sizeData = 20;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dati nazionali"),
      ),
      body: StoreConnector<AppState, List<National>>(
        converter: (store) => store.state.nationals,
        builder: (_, nationals) {
          print(nationals.length);
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            itemCount: nationals.length,
            itemBuilder: (_, int i) {
              National national = nationals[i];
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
                          "In data " + dateWithSlash(national.date),
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
                                data: national.newInfected.toString(),
                                sizeLabel: sizeLabel,
                                sizeData: sizeData,
                              ),
                            ),
                            Expanded(
                              child: LabelWithData(
                                label: "Deceduti",
                                data: national.dead.toString(),
                                sizeLabel: sizeLabel,
                                sizeData: sizeData,
                              ),
                            ),
                            Expanded(
                              child: LabelWithData(
                                label: "Guariti",
                                data: national.recovered.toString(),
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
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NationalDetailPage(
                      national: national,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

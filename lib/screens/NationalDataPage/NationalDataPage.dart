import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/CardWithData.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:new_coronavirus/screens/NationalDetailPage/NationalDetailPage.dart';
import 'package:new_coronavirus/utils/functions.dart';

class NationalDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    National getPrevData(List<National> nationals, int i) {
      try {
        return nationals[i + 1];
      } catch (e) {
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Dati nazionali"),
      ),
      body: StoreConnector<AppState, List<National>>(
        converter: (store) => store.state.nationals,
        builder: (_, nationals) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            itemCount: nationals.length,
            itemBuilder: (_, int i) {
              National national = nationals[i];
              return CardWithData(
                sizeLabel: 17,
                sizeData: 20,
                dead: national.dead.toString(),
                recovered: national.recovered.toString(),
                newInfected: national.newInfected.toString(),
                title: "In data " + dateWithSlash(national.date),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NationalDetailPage(
                      national: national,
                      prevData: getPrevData(nationals, i),
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

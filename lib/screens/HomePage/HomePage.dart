import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/row_text.dart';
import 'package:new_coronavirus/models/DataGroup.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/ResponseStatus.dart';
import 'package:new_coronavirus/network/HomeNetwork/HomeNetwork.dart';
import 'package:new_coronavirus/redux/actions/DataActions.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:new_coronavirus/screens/HomePage/components/LabelWithData.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getTotalData(Store<AppState> store) async {
    bool totalSuccess = true;
    int i = 0;
    http.Client client = http.Client();

    List<ResponseStatus> list = await Future.wait([
      HomeNetwork.getNationalData(client),
      HomeNetwork.getRegionalData(client),
    ]);

    client.close();

    while (i < list.length && totalSuccess) {
      if (!list[i].success) totalSuccess = false;
      i++;
    }

    if (totalSuccess) {
      DataGroup dataGroup = DataGroup(
        national: list[0].data,
        regional: list[1].data,
      );
      store.dispatch(SaveData(dataGroup));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ITALIA 🇮🇹"),
      ),
      body: StoreConnector<AppState, AppState>(
        onInit: (store) => getTotalData(store),
        converter: (store) => store.state,
        builder: (context, state) {
          List<National> nationals = state.nationals;
          National lastNational = nationals[0];
          return ListView(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            children: <Widget>[
              RowText(
                text1: "Andamento nazionale",
                text2: "Di più",
                onTextTap: () => print("prova"),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  LabelWithData(
                    label: "Casi totali",
                    data: lastNational.totalCases.toString(),
                  ),
                  LabelWithData(
                    label: "Nuovi infetti",
                    data: lastNational.newInfected.toString(),
                  ),
                  LabelWithData(
                    label: "Deceduti",
                    data: lastNational.dead.toString(),
                  ),
                  LabelWithData(
                    label: "Guariti",
                    data: lastNational.recovered.toString(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

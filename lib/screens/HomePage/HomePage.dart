import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/row_text.dart';
import 'package:new_coronavirus/models/DataGroup.dart';
import 'package:new_coronavirus/models/ResponseStatus.dart';
import 'package:new_coronavirus/network/HomeNetwork/HomeNetwork.dart';
import 'package:new_coronavirus/redux/actions/DataActions.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> getTotalData(Store<AppState> store) async {
    bool totalSuccess = true;
    int i = 0;
    http.Client client = http.Client();

    List<ResponseStatus> list = await Future.wait([
      HomeNetwork.getNationalData(client),
      HomeNetwork.getRegionalData(client),
      HomeNetwork.getProvincialData(client),
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
    return totalSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ITALIA 🇮🇹"),
      ),
      body: StoreConnector<AppState, AppState>(
        onInit: (store) => store.dispatch(getTotalData),
        converter: (store) => store.state,
        builder: (context, snapshot) {
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
            ],
          );
        },
      ),
    );
  }
}

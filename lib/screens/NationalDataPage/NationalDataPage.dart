import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';

class NationalDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dati nazionali"),
      ),
      body: StoreConnector<AppState, List<National>>(
        converter: (store) => store.state.nationals,
        builder: (_, nationals) {
          print(nationals.length);
          return ListView.builder(
            itemCount: nationals.length,
            itemBuilder: (_, int i) {
              National national = nationals[i];
              return Text(national.totalCases.toString());
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/components/row_text.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ITALIA 🇮🇹"),
      ),
      body: StoreConnector<AppState, AppState>(
          onInit: (store) => {},
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
          }),
    );
  }
}

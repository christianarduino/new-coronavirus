import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/models/Regional.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';

class RegionalDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Regional> renderList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dati regionali"),
      ),
      body: StoreConnector<AppState, List<Regional>>(
        converter: (store) => store.state.regional,
        builder: (context, regionalList) {
          renderList = regionalList;
          return StatefulBuilder(
            builder: (_, setState) {
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                children: <Widget>[
                  TextField(
                    onChanged: (String value) {
                      print(value);
                      if (value.isNotEmpty) {
                        setState(() {
                          renderList = regionalList
                              .where((Regional item) =>
                                  RegExp(value).hasMatch(item.name))
                              .toList();
                        });
                      } else {
                        setState(() {
                          renderList = regionalList;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: renderList.length,
                    itemBuilder: (_, int i) {
                      Regional regional = renderList[i];
                      return Text(regional.name);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

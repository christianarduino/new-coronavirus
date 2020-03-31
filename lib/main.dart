import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_coronavirus/redux/reducers/index.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';
import 'package:new_coronavirus/screens/HomePage/HomePage.dart';
import 'package:redux/redux.dart';

void main() {
  Store<AppState> store = Store<AppState>(
    reducers,
    initialState: AppState(),
  );
  runApp(
    NewCoronavirus(
      store: store,
    ),
  );
}

const Color accentColor = Color(0xFF4B887C);

class NewCoronavirus extends StatelessWidget {
  final Store<AppState> store;

  const NewCoronavirus({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: accentColor,
          appBarTheme: AppBarTheme(
            color: accentColor,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}

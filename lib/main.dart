import 'package:flutter/material.dart';
import 'package:new_coronavirus/screens/HomePage/HomePage.dart';

void main() => runApp(NewCoronavirus());

const Color accentColor = Color(0xFF4B887C);

class NewCoronavirus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: accentColor,
          appBarTheme: AppBarTheme(
            color: accentColor,
          ),
        ),
        home: HomePage());
  }
}

import 'package:flutter/material.dart';
import 'package:new_coronavirus/models/Regional.dart';

class HomeCard extends StatelessWidget {
  final LinearGradient gradient;
  final Regional regional;

  const HomeCard({Key key, this.gradient, this.regional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 250,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: gradient,
      ),
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/line.png",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  regional.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  regional.dead.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

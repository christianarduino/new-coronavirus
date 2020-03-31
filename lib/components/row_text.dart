import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onTextTap;

  const RowText({Key key, this.text1, this.text2, this.onTextTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        GestureDetector(
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).accentColor,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: onTextTap,
        ),
      ],
    );
  }
}

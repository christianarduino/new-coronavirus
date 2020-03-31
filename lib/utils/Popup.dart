import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Popup {
  static success(BuildContext context, String desc) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      tittle: "Successo",
      desc: desc,
    ).show();
  }

  static error(BuildContext context, String desc) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Prova di nuovo"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      tittle: "Attenzione",
      desc: desc,
    ).show();
  }

  static confirm(BuildContext context, String desc,
      {Function onOk, onCancel}) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Ok"),
        onPressed: onOk,
      ),
      btnCancel: FlatButton(
        child: Text("Torna indietro"),
        onPressed: onCancel,
      ),
      tittle: "Attenzione",
      desc: desc,
    ).show();
  }
}

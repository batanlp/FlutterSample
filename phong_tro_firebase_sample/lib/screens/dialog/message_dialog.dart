import 'package:flutter/material.dart';
import 'package:phong_tro/models/global.dart';

class MessageDialog {
  static void showMessageDialog(
      BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text(Global.ok),
                  onPressed: () {
                    Navigator.of(context).pop(MessageDialog);
                  },
                ),
              ],
            ));
  }
}

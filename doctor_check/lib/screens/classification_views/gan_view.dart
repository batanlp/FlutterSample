import 'package:flutter/material.dart';
import 'package:doctor_check/models/global.dart';
import 'package:doctor_check/utils/calculate_result.dart';
import 'package:doctor_check/screens/dialog_view/message_dialog.dart';
import 'package:doctor_check/screens/custom_view/custom_widget.dart';

class GanPage extends StatefulWidget {
  @override
  _GanPageState createState() => _GanPageState();
}

class _GanPageState extends State<GanPage> {
  CalculateResult _calculateResult = CalculateResult();
  String currentOpt1 = '';
  String currentOpt2 = '';
  String currentOpt3 = '';
  String currentOpt4 = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOpt1 = Global.gan_dropDown_opt1[0];
    currentOpt2 = Global.gan_dropDown_opt2[0];
    currentOpt3 = Global.gan_dropDown_opt3[0];
    currentOpt4 = Global.gan_dropDown_opt4[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.brown,
        child: Column(
          children: <Widget>[
            Text(
              Global.gan_opt1,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            CustomWidget.dropDownButton(
                textStyle, Global.gan_dropDown_opt1, currentOpt1, (value) {
              setState(() {
                currentOpt1 = value;
              });
            }),
            Container(
              height: 20,
            ),
            Text(
              Global.gan_opt2,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            CustomWidget.dropDownButton(
                textStyle, Global.gan_dropDown_opt2, currentOpt2, (value) {
              setState(() {
                currentOpt2 = value;
              });
            }),
            Container(
              height: 20,
            ),
            Text(
              Global.gan_opt3,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            CustomWidget.dropDownButton(
                textStyle, Global.gan_dropDown_opt3, currentOpt3, (value) {
              setState(() {
                currentOpt3 = value;
              });
            }),

            Container(
              height: 20,
            ),
            Text(
              Global.gan_opt4,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            CustomWidget.dropDownButton(
                textStyle, Global.gan_dropDown_opt4, currentOpt4, (value) {
              setState(() {
                currentOpt4 = value;
              });
            }),

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  onPressed: showResult,
                  child: Text(
                    Global.result,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showResult() {
    int result =
        _calculateResult.calculateGan(currentOpt1, currentOpt2, currentOpt3, currentOpt4);

    MessageDialog.showMessageDialog(
        context, Global.result, Global.gan_result[result]);
  }
}
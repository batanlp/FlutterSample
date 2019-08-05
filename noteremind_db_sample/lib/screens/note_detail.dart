import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:noteremind/models/note_object.dart';
import 'package:noteremind/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/date_symbol_data_custom.dart';

class NoteDetail extends StatefulWidget {
  final String noteTitle;
  final Notes note;

  NoteDetail(this.note, this.noteTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailState(this.note, this.noteTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  static var dropDownList = ["High", "Low"];
  String currentSelect = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController subController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSelect = dropDownList[0];
  }

  String titleNote;
  Notes note;
  NoteDetailState(this.note, this.titleNote);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    subController.text = note.des;

    // TODO: implement build
    return WillPopScope(

      onWillPop: () {
        moveBack();
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text(titleNote),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveBack();
          },
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: dropDownList.map((String dropItem) {
                  return DropdownMenuItem<String>(
                    value: dropItem,
                    child: Text(dropItem),
                  );
                }).toList(),

                style: textStyle,
                value: getPriorityByString(note.priority),

                onChanged: (value) {
                  setState(() {
                    // currentSelect = value;
                    updatePriorityValue(value);
                  });
                }
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  updateTitle();
                },

                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: subController,
                style: textStyle,
                onChanged: (value) {
                  updateDesc();
                },

                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _save();
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _delete();
                        });
                      },
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
      ));
  }

  void moveBack() {
    Navigator.pop(context, true);
  }

  void updatePriorityValue(String value) {
    if (value == 'High') {
      note.priority = 2;
    }
    else {
      note.priority = 1;
    }
  }

  String getPriorityByString (int value) {
    String output = dropDownList[0];

    if (value == 1) {
      output = dropDownList[1];
    }
    return output;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDesc() {
    note.des = subController.text;
  }

  void _delete() async {
    moveBack();
    int result;
    if (note.id != null) {
      result = await databaseHelper.deleteNote(note.id);
    }
    else {
      _showAlertDialog("Status", "No Note deleted");
      return;
    }

    if (result != 0) {
      _showAlertDialog("Status", "Deleted");
    }
  }

  void _save() async {
    moveBack();

    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (note.id != null) {
      // update
      result = await databaseHelper.updateNote(note);
    }
    else {
      // new
      result = await databaseHelper.insert(note);
    }

    if (result != 0) {
      _showAlertDialog("Status", "Saved");
    }
    else {
      _showAlertDialog("Status", "Fail!");
    }
  }

  void _showAlertDialog(String status, String msg) {
    AlertDialog dlg = AlertDialog(
      title: Text(status),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => dlg);
  }
}
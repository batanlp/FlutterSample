import 'package:flutter/material.dart';
import 'note_detail.dart';
import 'dart:async';
import 'package:noteremind/models/note_object.dart';
import 'package:noteremind/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  int count = 0;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notes> noteList;

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Notes>();
      updateListView();
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),

      body: getNoteListView(),
      
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          debugPrint("FAB click");
          gotoNoteDetail(Notes('', '', 2), "New note");
        },

        tooltip: "Add noted",

        child: Icon(Icons.add),
      ),

    );
  }

  ListView getNoteListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),

            title: Text(this.noteList[position].title, style: textStyle,),

            subtitle: Text(this.noteList[position].date),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _deleteNote(context, this.noteList[position]);
              },
            ),

            onTap: () {
              debugPrint('Click to view note detail');
              gotoNoteDetail(this.noteList[position], "Edit note");
            },
          ),
        );
      },
    );
  }

  void gotoNoteDetail(Notes note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result) {
      updateListView();
    }
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.yellow;
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _deleteNote(BuildContext context, Notes note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar(context, 'Note delete successed');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> db = databaseHelper.initDatabase();
    db.then((database) {
      Future<List<Notes>> futureNotes = databaseHelper.getNoteList();
      // noteList = await databaseHelper.getNoteList();
      
      futureNotes.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
import 'package:flutter/material.dart';
import 'package:doctor_check/utils/app_system.dart';
import 'package:doctor_check/models/global.dart';
import 'package:doctor_check/screens/classification_views/gan_view.dart';
import 'package:doctor_check/screens/classification_views/than_view.dart';
import 'package:doctor_check/screens/classification_views/lach_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      home: DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: () {
            AppSystem.exitAppIfNeed();
          },
          child: Scaffold(
            drawer: Drawer(
              child: Container(
                color: Colors.grey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: DrawerHeader(
                        child: Text('abc'),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                      },
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              title: Text(Global.home),
            ),
            body: TabBarView(
              children: [
                new Container(
                  color: Colors.white,
                  //child: getForRentList(),
                  child: GanPage(),
                ),
                new Container(
                  color: Colors.orange,
                  child: ThanPage(),
                ),
                new Container(
                  color: Colors.lightGreen,
                  child: LachPage(),
                ),
              ],
            ),
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  //icon: new Icon(Icons.home),
                  text: Global.aastGan,
                ),
                Tab(
                  //icon: new Icon(Icons.rss_feed),
                  text: Global.aastThan,
                ),
                Tab(
                  //icon: new Icon(Icons.perm_identity),
                  text: Global.aastLach,
                ),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  ListView getForRentList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.info),
            ),
            title: Text('Abc'),
            subtitle: Text('123'),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                //_deleteNote(context, this.noteList[position]);
              },
            ),
            onTap: () {
              debugPrint('Click to view note detail');
              //gotoNoteDetail(this.noteList[position], "Edit note");
            },
          ),
        );
      },
    );
  }
}

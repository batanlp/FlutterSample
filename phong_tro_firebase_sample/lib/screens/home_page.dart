import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phong_tro/screens/addnew_page.dart';
import 'package:phong_tro/utils/app_system.dart';
import 'package:phong_tro/models/global.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser _user;
  HomePage(this._user);

  @override
  _HomePageState createState() => _HomePageState(this._user);
}

class _HomePageState extends State<HomePage> {
  FirebaseUser _user;
  _HomePageState(this._user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppSystem.requestLocationService();
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
            floatingActionButton: FloatingActionButton(
              onPressed:() {
                gotoAddNew();
              },
              tooltip: "Add news",
              child: Icon(Icons.add),
            ),
            drawer: Drawer(
              child: Container(
                color: Colors.grey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: DrawerHeader(
                        child: Text(_user.displayName),
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
              title: Text('Home'),
            ),
            body: TabBarView(
              children: [
                new Container(
                  color: Colors.white,
                  child: getForRentList(),
                ),
                new Container(
                  color: Colors.orange,
                ),
                new Container(
                  color: Colors.lightGreen,
                ),
              ],
            ),
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.home),
                  text: 'For Rent',
                ),
                Tab(
                  icon: new Icon(Icons.rss_feed),
                  text: 'Need Rent',
                ),
                Tab(
                  icon: new Icon(Icons.perm_identity),
                  text: 'Profile',
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

  void gotoAddNew() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNewPage(this._user)));
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
              child: Icon(Icons.delete, color: Colors.grey,),
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

  void exitAppForAndroid() {

  }
}

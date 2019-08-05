import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:phong_tro/bloc/addnew_bloc.dart';
import 'package:phong_tro/models/global.dart';
import 'package:phong_tro/models/news_object.dart';
import 'package:phong_tro/screens/dialog/message_dialog.dart';
import 'package:phong_tro/screens/select_location_page.dart';
import 'package:phong_tro/utils/app_system.dart';

class AddNewPage extends StatefulWidget {
  final FirebaseUser _user;
  AddNewPage(this._user);

  @override
  _AddNewPageState createState() => _AddNewPageState(this._user);
}

class _AddNewPageState extends State<AddNewPage> {
  FirebaseUser _user;
  _AddNewPageState(this._user);

  NewsObject _newsObject = NewsObject.empty();
  AddNewBloc _addNewBloc = AddNewBloc();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  String _desc = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressController.dispose();
    _descController.dispose();
    _addNewBloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsObject.userId = this._user.uid;
    _newsObject.type = Global.dropAddNewList[0];
    _newsObject.price = Global.dropPriceList[0];
    _newsObject.location = new Coordinates(0.0, 0.0);

    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(Global.addNew),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Column(
          children: <Widget>[
            DropdownButton(
                isExpanded: true,
                items: Global.dropAddNewList.map((String dropItem) {
                  return DropdownMenuItem<String>(
                    value: dropItem,
                    child: Text(dropItem),
                  );
                }).toList(),
                value: _newsObject.type,
                onChanged: (value) {
                  setState(() {
                    _newsObject.type = value;
                    //updatePriorityValue(value);
                  });
                }),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  Global.newsLocation,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
            Row(
              children: <Widget>[
                Text(
                  Global.district,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
                Container(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text('1'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                StreamBuilder(
                  stream: _addNewBloc.addressStream,
                  builder: (context, snapshot) => TextField(
                    style: TextStyle(fontSize: 15, color: Colors.green),
                    controller: _addressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      errorText:
                      snapshot.hasError ? snapshot.error : null,
                      labelText: Global.address,
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(Icons.my_location),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.location_searching,
                  ),
                  tooltip: Global.guideSelectLocation,
                  onPressed: () {
                    onClickSelectLocation();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: DropdownButton(
                  isExpanded: true,
                  items: Global.dropPriceList.map((String dropItem) {
                    return DropdownMenuItem<String>(
                      value: dropItem,
                      child: Text(dropItem),
                    );
                  }).toList(),
                  value: _newsObject.price,
                  onChanged: (value) {
                    setState(() {
                      _newsObject.price = value;
                      //updatePriorityValue(value);
                    });
                  }),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: StreamBuilder(
                stream: _addNewBloc.descStream,
                builder: (context, snapshot) => TextField(
                  onTap: onDescriptionFocus,
                  onEditingComplete: onDescriptionEnd,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: _descController,
                  decoration: InputDecoration(
                    errorText:
                    snapshot.hasError ? snapshot.error : null,
                    labelText: _desc,
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.green, width: 1),
                      borderRadius:
                      BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  onPressed: onClickAddNews,
                  child: Text(
                    Global.addNew,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickSelectLocation() {
    // Move to map select location
    Future<bool> permission = AppSystem.isLocationServiceEnable();
    permission.then((result) async {
      if (result) {
        // For debug purpose only
        // ...
        if (Global.showLog) {
          if (_newsObject.location.longitude == 0.0) {
            _newsObject.location = Coordinates(10.6, 106.10);
          }
        }
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectLocationPage(_newsObject.location, _addressController.text)));
        // result is callback data, the same with delegate
        // ...
        //print(result);
        // address, location
        print(result[0]);
        print(result[1]);
        updateNewAddress(result[0], result[1]);

      } else {
        MessageDialog.showMessageDialog(
            context, Global.alertFail, Global.msgEnableGPS);
      }
    });
  }

  void updateLocation() {
    Future<bool> permission = AppSystem.isLocationServiceEnable();
    permission.then((result) {
      if (result == true) {
        _addNewBloc.getCurrentLocation((locationCord) {
          if (locationCord != null) {
            _newsObject.location = Coordinates(locationCord.latitude, locationCord.longitude);
            _addNewBloc.geocoderFromCord(locationCord, (address) {
              if (address != '') {
                _addressController.text = address;
                _newsObject.address = address;
              }
            });
          }
        });
      }
    });
  }

  void updateNewAddress(String address, Coordinates coord) {
    if (address != null) {
      _addressController.text = address;
      _newsObject.address = address;
      if (coord != null) {
        _newsObject.location = coord;
      }
      else {
        _newsObject.location = Coordinates(0, 0);
      }
    }
  }

  void onClickAddNews() {
    _newsObject.description = _descController.text;
    _addNewBloc.verifyInfo(_newsObject);
  }

  void onDescriptionFocus() {
    setState(() {
      _desc = Global.description;
    });
  }

  void onDescriptionEnd() {
    if (_descController.text == '') {
      setState(() {
        _desc = '';
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:rainbow_flutter/Camera.dart';

class HomeCameraPage extends StatefulWidget {

  HomeCameraPage({Key key, this.cameras, this.title}) : super(key: key);

  final String title;
  final List<CameraDescription> cameras;
  @override
  _HomeCameraPage createState() => _HomeCameraPage();
}

class _HomeCameraPage extends State<HomeCameraPage> {
  String _text = "";
  String _confident = "";
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
        ],
      ),
    );
  }

  setRecognitions(text, conf, imageHeight, imageWidth) {
    final snackBar = SnackBar(content: Text('$text - $conf'));

    // Find the Scaffold in the Widget tree and use it to show a SnackBar
    //Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
    /*
    setState(() {
      //print(_text);
      _text = text;
      _confident = conf;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;

      final snackBar = SnackBar(content: Text('$_text - $_confident'));

      // Find the Scaffold in the Widget tree and use it to show a SnackBar
      Scaffold.of(context).showSnackBar(snackBar);
    });
    */
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:rainbow_flutter/result_vision.dart';

import 'package:camera/camera.dart';
import 'dart:async';
import 'package:rainbow_flutter/CameraHome.dart';


List<CameraDescription> cameras;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeCameraPage(cameras: cameras, title: 'Rainbow Demo'),
    );
  }
}

/*
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Rainbow Demo'),
    );
  }
}
*/

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title),

      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: onOpenPhotoClick,
                  child: Text(
                    "Gallery",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
              ),
              SizedBox(
                width: 150,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: onOpenCameraClick,
                  child: Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: onDeviceClick,
                  child: Text(
                    "On-Device",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
              ),
              SizedBox(
                width: 150,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: onCloudClick,
                  child: Text(
                    "Cloud",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future onOpenPhotoClick() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future onOpenCameraClick() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future onDeviceClick() async {
    if (_image == null) {
      return;
    }
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
    final ImageLabeler onDevice = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels = await onDevice.processImage(visionImage);

    gotoResult(labels, 'OnDevice');
    /*
    for (ImageLabel label in labels) {
      final String text = label.text;
      //final String entityId = label.entityId;
      final double confidence = label.confidence;

      print(text);
      print(confidence);
    }
    */
  }

  Future onCloudClick() async {
    if (_image == null) {
      return;
    }
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
    final ImageLabeler cloudLabeler = FirebaseVision.instance.cloudImageLabeler();
    final List<ImageLabel> labels = await cloudLabeler.processImage(visionImage);
    gotoResult(labels, "Cloud");
    /*
    for (ImageLabel label in labels) {
      final String text = label.text;
      final String entityId = label.entityId;
      final double confidence = label.confidence;

      print(text);
      print(confidence);
    }
    */
  }

  Future gotoResult(List<ImageLabel> labels, String title) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VisionResult(labels, title);
    }));
  }
}

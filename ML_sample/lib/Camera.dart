import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:tflite/tflite.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:math' as math;
import 'dart:core';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

typedef void Callback(String text, String conf, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.medium,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) async {
          //print(isDetecting);
          if (!isDetecting) {
            isDetecting = true;

            //print("scanning!...");

            //int startTime = new DateTime.now().millisecondsSinceEpoch;

            final FirebaseVisionImageMetadata metadata =
                FirebaseVisionImageMetadata(
                    rawFormat: img.format.raw,
                    //size: Size(1.0, 1.0),
                    size: Size(img.width.toDouble(), img.height.toDouble()),
                    planeData: img.planes
                        .map((currentPlane) => FirebaseVisionImagePlaneMetadata(
                            bytesPerRow: currentPlane.bytesPerRow,
                            height: currentPlane.height,
                            width: currentPlane.width))
                        .toList());

            //final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
            final FirebaseVisionImage visionImage =
                FirebaseVisionImage.fromBytes(img.planes[0].bytes, metadata);
            final ImageLabeler onDevice =
                FirebaseVision.instance.imageLabeler();
            final List<ImageLabel> labels =
                await onDevice.processImage(visionImage);

            for (ImageLabel label in labels) {
              final String text = label.text;
              //final String entityId = label.entityId;
              final double confidence = label.confidence;
              if (text.toUpperCase() == 'RAINBOW' ||
                  text.toUpperCase() == 'MOBILE PHONE' ||
                  text.toUpperCase() == 'CHAIR') {
                widget.setRecognitions(
                    text, confidence.toString(), img.height, img.width);
              }
              //print(text);
              //print(confidence);
            }
            isDetecting = false;
            //gotoResult(labels, 'OnDevice');
            /*
            Tflite.detectObjectOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              model: widget.model == yolo ? "YOLO" : "SSDMobileNet",
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: widget.model == yolo ? 0 : 127.5,
              imageStd: widget.model == yolo ? 255.0 : 127.5,
              numResultsPerClass: 1,
              threshold: widget.model == yolo ? 0.2 : 0.4,
            ).then((recognitions) {
              // print(recognitions);

              int endTime = new DateTime.now().millisecondsSinceEpoch;
              print("Detection took ${endTime - startTime}");

              widget.setRecognitions(recognitions, img.height, img.width);

              isDetecting = false;
            });
            */

          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}

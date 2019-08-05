import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class VisionResult extends StatefulWidget {
  final List<ImageLabel> labels;
  final String title;
  VisionResult(this.labels, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VisionResultState(this.labels, this.title);
  }
}

class _VisionResultState extends State<VisionResult> {
  List<ImageLabel> labels;
  final String title;

  _VisionResultState(this.labels, this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: showResultList(),
    );
  }

  ListView showResultList() {
    return ListView.builder(
      itemCount: labels.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.play_arrow),
            ),
            title: Text(
                '${this.labels[position].text} - ${this.labels[position].confidence}'),
          ),
        );
      },
    );
  }
}

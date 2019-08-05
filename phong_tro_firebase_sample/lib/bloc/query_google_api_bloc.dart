
import 'dart:async';
import 'package:phong_tro/models/google_place_query_items.dart';
import 'package:phong_tro/utils/network_connection.dart';
import 'dart:convert';

class QueryGoogleBloc {
  var _placeController = StreamController();
  Stream get placeStream => _placeController.stream;

  var _network = NetworkConnection();

  void searchPlace(String keyword) {
    _placeController.sink.add("start");
    _network.queryGooglePlaceApi(keyword, (result) {
      _placeController.sink.add(GoogleAPIQueryPlace.fromJson(json.decode(result)));
    }, (error) {
      _placeController.sink.add("stop");
    });
  }

  void dispose() {
    _placeController.close();
  }
}
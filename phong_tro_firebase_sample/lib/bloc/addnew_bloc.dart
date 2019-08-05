import 'dart:async';
import 'package:location/location.dart';
import 'package:phong_tro/models/global.dart';
import 'package:phong_tro/models/news_object.dart';
import 'package:phong_tro/utils/location_service.dart';

class AddNewBloc {

  LocationService _locationService = LocationService();
  StreamController _addressController = StreamController();
  StreamController _descriptionController = StreamController();

  Stream get addressStream => _addressController.stream;
  Stream get descStream => _descriptionController.stream;

  void getCurrentLocation(Function(LocationData) locationCord) {
    _locationService.getCurrentLocation(locationCord);
  }

  void geocoderFromCord(LocationData locationCord, Function(String) address) {
    _locationService.geocodeFromcoordinates(locationCord, address);
  }

  bool verifyInfo(NewsObject newsInfo) {
    if (newsInfo.address == null || newsInfo.address.length == 0) {
      _addressController.sink.addError(Global.msgNonEmpty);
      return false;
    }
    _addressController.sink.add('');

    if (newsInfo.description == null || newsInfo.description.length == 0) {
      _descriptionController.sink.addError(Global.msgNonEmpty);
      return false;
    }
    _descriptionController.sink.add('');

    // ...

    return true;
  }

  void dispose() {
    _addressController.close();
    _descriptionController.close();
  }
}
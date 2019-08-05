import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';

class LocationService {
  void getCurrentLocation(Function(LocationData) locationCord ) async {
    Location location = Location();
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var currentLocation = await location.getLocation();
      locationCord(currentLocation);
      //print(currentLocation.latitude);
      //print(currentLocation.longitude);
    } on PlatformException catch (e) {
      print(e.code);
      locationCord(null);
    }
  }

  void geocodeFromcoordinates(LocationData location, Function(String) address) async {
    final coordinates = new Coordinates(location.latitude, location.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    // print(first);
    if (first != null) {
      address(first.addressLine);
    }
    else {
      address('');
    }
  }

  void getCordFromAddress(String address) async {
    var cord = await Geocoder.local.findAddressesFromQuery(address);
    var first = cord.first;
    print("${first.featureName} : ${first.coordinates}");


  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:phong_tro/models/global.dart';
import 'package:phong_tro/models/google_place_query_items.dart';
import 'package:phong_tro/screens/query_google_api_page.dart';
import 'package:phong_tro/utils/app_system.dart';
//import 'package:phong_tro/utils/location_service.dart';
import 'package:geocoder/model.dart';

class SelectLocationPage extends StatefulWidget {
  final Coordinates _coord;
  final String _address;
  SelectLocationPage(this._coord, this._address);

  @override
  _SelectLocationPageState createState() =>
      _SelectLocationPageState(this._coord, this._address);
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  // Coord from previous page
  final Coordinates _coord;
  final String _address;
  _SelectLocationPageState(this._coord, this._address);

  var _currentMapType;
  final Set<Marker> _markers = {};

  // Data back when pop
  Location _selectedLocation = new Location(0.0, 0.0);
  String _selectAddress = 'none';

  //Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;
  String _googkeAPIKey = '';
  GoogleMapsPlaces _places;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentMapType = MapType.normal;
    _googkeAPIKey = AppSystem.getGoogleAPIKey();
    _places = new GoogleMapsPlaces(apiKey: _googkeAPIKey);

    if (Global.showLog) {
      print('Current coord: $_coord');
      print('Current address: $_address');
    }

    if (_coord.longitude != 0.0) {
      _selectedLocation = Location(_coord.latitude, _coord.longitude);
      _selectAddress = this._address;
      dropMaker(_selectedLocation, _selectAddress, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              // myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
              mapType: _currentMapType,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                zoom: 15,
                target: LatLng(_coord.latitude, _coord.longitude),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(''),
                    leading: FlatButton(
                      onPressed: moveBack,
                      child: Icon(Icons.arrow_back),
                    ),
                    actions: <Widget>[
                      IconButton(
                        color: Colors.green,
                        onPressed: onSearchLocation,
                        icon: Icon(Icons.search),
                      ),
                      IconButton(
                        color: Colors.green,
                        onPressed: swithMapType,
                        icon: Icon(Icons.map),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveBack() {
    Navigator.pop(context, [
      _selectAddress,
      Coordinates(_selectedLocation.lat, _selectedLocation.lng)
    ]);
  }

  void swithMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void onSearchLocation() async {
    /*
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: _googkeAPIKey,
      mode: Mode.fullscreen,
    );
    displayPrediction(p, _scaffoldKey.currentState);
    */
    // change to use google api
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QueryGoogleApiPage()));

    var newLocation = result[0] as GoogleAPIQueryPlace;
    // print(selectOf.address);

    updateNewLocation(newLocation);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      await _places.getDetailsByPlaceId(p.placeId).then((detailResult) {
        Future.delayed(const Duration(seconds: 1), () {
          // Catch over limit query here ....
          if (detailResult == null || detailResult.result == null) {
            scaffold.showSnackBar(
                new SnackBar(content: new Text(detailResult.errorMessage)));
          } else {
            dropMakerAndUpdateMap(detailResult.result);
            scaffold.showSnackBar(new SnackBar(
                content: new Text(detailResult.result.formattedAddress)));
          }
        });
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      scaffold.showSnackBar(
          new SnackBar(content: new Text(Global.msgGeocoderError)));
    }
  }

  void _onCameraMove(CameraPosition position) {
    // _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    //_controller.complete(controller);
    _mapController = controller;
  }

  void updateNewLocation(GoogleAPIQueryPlace _newLocation) {
    Location location = new Location(_newLocation.lat, _newLocation.lng);
    _selectedLocation = location;
    _selectAddress = _newLocation.address;
    setState(() {
      var mapPosition = LatLng(location.lat, location.lng);
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(mapPosition.toString()),
        position: mapPosition,
        infoWindow: InfoWindow(
          title: Global.address,
          snippet: _newLocation.address,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: mapPosition, zoom: 18.0)));
    });
  }

  void dropMakerAndUpdateMap(PlaceDetails result) {
    Location location = result.geometry.location;
    _selectedLocation = location;
    _selectAddress = result.formattedAddress;
    dropMaker(_selectedLocation, _selectAddress, true);
  }

  void dropMaker(Location location, String address, bool animate) {
    setState(() {
      var mapPosition = LatLng(location.lat, location.lng);
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(mapPosition.toString()),
        position: mapPosition,
        infoWindow: InfoWindow(
          title: Global.address,
          snippet: address,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      if (animate) {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: mapPosition, zoom: 18.0)));
      }
    });
  }
}

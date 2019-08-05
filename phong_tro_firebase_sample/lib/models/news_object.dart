import 'package:geocoder/model.dart';

class NewsObject {
  String _userId;
  String _type; // for_rent, need_rent
  String _city;
  String _district;
  String _address;
  Coordinates _location; // lat, long
  String _price;
  String _description;

  NewsObject.empty();
  NewsObject(this._userId, this._type, this._city, this._district, this._address, this._location, this._price, this._description);

  String get userId => _userId;
  String get type => _type;
  String get city => _city;
  String get district => _district;
  String get address => _address;
  Coordinates get location => _location;
  String get price => _price;
  String get description => _description;

  set userId(String newValue) {
    this._userId = newValue;
  }

  set type(String newValue) {
    if (newValue.length <= 255) {
      this._type = newValue;
    }
  }

  set city(String newValue) {
    if (newValue.length <= 255) {
      this._city = newValue;
    }
  }

  set district(String newValue) {
    if (newValue.length <= 255) {
      this._district = newValue;
    }
  }

  set address(String newValue) {
    if (newValue.length <= 255) {
      this._address = newValue;
    }
  }

  set location(Coordinates newValue) {
    this._location = newValue;
  }

  set price(String newValue) {
    this._price = newValue;
  }

  set description(String newValue) {
    this._description = newValue;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['type'] = _type;
    map['city'] = _city;
    map['district'] = _district;
    map['address'] = _address;
    map['location'] = _location;
    map['price'] = _price;
    map['description'] = _description;

    return map;
  }

  NewsObject.fromMapObject(Map<String, dynamic> map) {
    this._type = map['type'];
    this._city = map['city'];
    this._district = map['district'];
    this._address = map['address'];
    this._location = map['location'];
    this._price = map['price'];
    this._description = map['description'];
  }
}
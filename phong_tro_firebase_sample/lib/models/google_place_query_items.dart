class GoogleAPIQueryPlace {
  String name;
  String address;
  double lat;
  double lng;

  GoogleAPIQueryPlace(this.name, this.address, this.lat, this.lng);

  static List<GoogleAPIQueryPlace> fromJson(Map<String, dynamic> json) {
    List<GoogleAPIQueryPlace> ret = new List();
    var results = json['results'] as List;

    for (var item in results) {
      var result = new GoogleAPIQueryPlace(
        item['name'],
        item['formatted_address'],
        item['geometry']['location']['lat'],
        item['geometry']['location']['lng'],
      );

      ret.add(result);
    }
    return ret;
  }
}
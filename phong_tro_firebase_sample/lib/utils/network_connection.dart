import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:phong_tro/models/global.dart';
import 'package:phong_tro/utils/app_system.dart';

class NetworkConnection {

  Future<String> sendGetRequest(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      //return Post.fromJson(json.decode(response.body));
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      // throw Exception('Failed to load post');
    }
    return null;
  }

  void getFacebookUserInfo(String token, Function(String) fbUserInfo, Function(String) onError) async {
    // ignore: unnecessary_brace_in_string_interps
    var response = await sendGetRequest('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    if (response != null) {
      fbUserInfo(response);
    }
    else {
      onError(Global.msgNetworkError);
    }
  }

  void queryGooglePlaceApi(String query, Function(String) onResponse, Function(String) onError) async {
    var baseUrl = AppSystem.getGoogleAPIQuery(AppSystem.getGoogleAPIKey());
    var encodeQuery = Uri.encodeQueryComponent(query);
    var response = await sendGetRequest('$baseUrl$encodeQuery');
    if (response != null) {
      onResponse(response);
    }
    else {
      onError(Global.msgNetworkError);
    }
  }
}
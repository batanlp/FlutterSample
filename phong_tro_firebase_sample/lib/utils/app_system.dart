import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:phong_tro/models/global.dart';
import 'package:permission_handler/permission_handler.dart';

class AppSystem {
  static void exitAppIfNeed() {
    if (Platform.isAndroid) {
      // Android-specific code
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      // iOS-specific code
    }
  }

  static void requestLocationService() async {
    /*
    var location = new Location();
    print('aaaaaaa');
    location.requestPermission().then((result) {
      if (!result) {
        print('request location');
        location.requestService();
      }
    });
    */
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]);
    //print(permissions.values);
  }

  static Future<bool> isLocationServiceEnable() {
    var location = new Location();
    return location.serviceEnabled();
    //return PermissionHandler().checkPermissionStatus(PermissionGroup.location);
  }

  static String getGoogleAPIKey() {
    if (Platform.isAndroid) {
      return Global.androidGoogleAPIKey;
    }
    return Global.iOSGoogleAPIKey;
  }

  static String getGoogleAPIQuery(String key) {
    return 'https://maps.googleapis.com/maps/api/place/textsearch/json?key=$key&language=vi&region=vi&query=';
  }
}
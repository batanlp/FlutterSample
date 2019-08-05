import 'dart:io' show Platform;
import 'package:flutter/services.dart';

class AppSystem {
  static void exitAppIfNeed() {
    if (Platform.isAndroid) {
      // Android-specific code
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      // iOS-specific code
    }
  }
}
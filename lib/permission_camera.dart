
import 'package:flutter/services.dart';


class PermissionCamera{

  static Future<bool> requestCameraPermission() async {
    MethodChannel _channel = const MethodChannel('dev/camera');
    final bool granted = await _channel.invokeMethod('requestCameraPermission');
    return granted;
  }

}


import 'dart:async';
import 'package:flutter/services.dart';

import 'permission_camera.dart';

class PermissionService {


  static Future<bool> requestCameraPermission() async {
    final bool granted = await  await PermissionCamera.requestCameraPermission();
    return granted;
  }
}

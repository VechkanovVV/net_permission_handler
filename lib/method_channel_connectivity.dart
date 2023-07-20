import 'dart:async';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'connectivity_platform_interface.dart';
import 'src/utils.dart';

class MethodChannelConnectivity extends ConnectivityPlatform {
  // MethodChannel for invoking platform methods.
  MethodChannel methodChannel = const MethodChannel('dev/connectivity');

  // EventChannel for receiving connectivity status changes from the platform.
  EventChannel eventChannel = const EventChannel('dev/connectivity_status');

  // Private variable to hold the Stream of ConnectivityResult events.
  Stream<ConnectivityResult>? _onConnectivityChanged;

  @override
  // Getter for onConnectivityChanged that listens to the platform's eventChannel and maps the result to ConnectivityResult events.
  Stream<ConnectivityResult> get onConnectivityChanged {
    _onConnectivityChanged ??= eventChannel
        .receiveBroadcastStream()
        .map((dynamic result) => result.toString()) // Convert the event result to a String.
        .map(parseConnectivityResult); // Convert the String to a ConnectivityResult enum using the parseConnectivityResult function.
    return _onConnectivityChanged!;
  }

  @override
  // Method for checking connectivity by invoking the 'check' method on the platform.
  Future<ConnectivityResult> checkConnectivity() {
    return methodChannel
        .invokeMethod<String>('check') // Invoke the 'check' method on the platform and get a String result.
        .then((value) => parseConnectivityResult(value ?? '')); // Convert the String result to a ConnectivityResult enum using the parseConnectivityResult function.
  }
}
import 'dart:async';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_connectivity.dart';
import 'src/enums.dart';

// Exporting the enums file to make it accessible outside this package.
export 'src/enums.dart';

// Abstract class representing the platform interface for connectivity.
abstract class ConnectivityPlatform extends PlatformInterface {
  // Constructor for the abstract class.
  ConnectivityPlatform() : super(token: _token);

  // Private static token used to verify the instance of the platform implementation.
  static final Object _token = Object();

  // Private static variable to hold the default implementation of ConnectivityPlatform.
  static ConnectivityPlatform _instance = MethodChannelConnectivity();

  // Getter to access the default implementation of ConnectivityPlatform.
  static ConnectivityPlatform get instance => _instance;

  // Setter to set the default implementation of ConnectivityPlatform.
  static set instance(ConnectivityPlatform instance) {
    // Verify the token to ensure the instance is valid for this class.
    PlatformInterface.verifyToken(instance, _token);
    // Set the instance to the provided implementation.
    _instance = instance;
  }

  // Abstract method to be implemented by platform-specific classes.
  // It returns a Future that holds a ConnectivityResult value.
  Future<ConnectivityResult> checkConnectivity();

  // Abstract getter to be implemented by platform-specific classes.
  // It returns a Stream that emits ConnectivityResult events when the connectivity changes.
  Stream<ConnectivityResult> get onConnectivityChanged;
}
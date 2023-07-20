import 'dart:async';
import 'connectivity_platform_interface.dart';

// Exporting 'ConnectivityResult' to make it accessible outside this file.
export 'connectivity_platform_interface.dart' show ConnectivityResult;

// A Singleton class that provides a simple and unified API for checking connectivity status.
class Connectivity {
  // Private static instance of the Connectivity class.
  static final Connectivity _instance = Connectivity._();

  // Private static instance of the platform-specific connectivity implementation.
  static final ConnectivityPlatform _platform = ConnectivityPlatform.instance;

  // Factory constructor to return the single instance of the Connectivity class.
  factory Connectivity() => _instance;

  // Private constructor to prevent direct instantiation of the class.
  Connectivity._();

  // Getter for accessing the Stream that emits connectivity changes.
  // This getter delegates the call to the platform-specific implementation.
  Stream<ConnectivityResult> get onConnectivityChanged => _platform.onConnectivityChanged;

  // Method to check the current connectivity status.
  // This method delegates the call to the platform-specific implementation.
  Future<ConnectivityResult> checkConnectivity() => _platform.checkConnectivity();
}
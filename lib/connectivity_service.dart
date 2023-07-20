
import 'connectivity.dart';
import 'connectivity_platform_interface.dart';

class ConnectivityService {
  static Future<String> checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return "mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return "wifi";
    } else {
      return "none";
    }
  }

  Stream<String> get connectivityStatusStream {
    return Connectivity()
        .onConnectivityChanged
        .map((ConnectivityResult result) => _mapConnectivityResultToString(result))
        .distinct();
  }

  String _mapConnectivityResultToString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return "mobile";
      case ConnectivityResult.wifi:
        return "wifi";
      default:
        return "none";
    }
  }
}


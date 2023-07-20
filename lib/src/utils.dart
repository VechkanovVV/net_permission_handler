import '../connectivity.dart';



ConnectivityResult parseConnectivityResult(String state) {
  switch (state) {

    case 'wifi':
      return ConnectivityResult.wifi;
    case 'mobile':
      return ConnectivityResult.mobile;
    case 'none':
    default:
      return ConnectivityResult.none;
  }
}

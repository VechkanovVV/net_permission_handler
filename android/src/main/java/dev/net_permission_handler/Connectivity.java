package dev.net_permission_handler;

import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.os.Build;

public class Connectivity {
  static final String CONNECTIVITY_NONE = "none";
  static final String CONNECTIVITY_WIFI = "wifi";
  static final String CONNECTIVITY_MOBILE = "mobile";
  static final String CONNECTIVITY_ETHERNET = "ethernet";
  static final String CONNECTIVITY_BLUETOOTH = "bluetooth";
  static final String CONNECTIVITY_VPN = "vpn";
  private final ConnectivityManager connectivityManager;

  public Connectivity(ConnectivityManager connectivityManager) {
    this.connectivityManager = connectivityManager;
  }

  String getNetworkType() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      Network network = connectivityManager.getActiveNetwork();
      NetworkCapabilities capabilities = connectivityManager.getNetworkCapabilities(network);
      if (capabilities != null) {
        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
          return CONNECTIVITY_WIFI;
        }
        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
          return CONNECTIVITY_ETHERNET;
        }
        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN)) {
          return CONNECTIVITY_VPN;
        }
        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
          return CONNECTIVITY_MOBILE;
        }
        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH)) {
          return CONNECTIVITY_BLUETOOTH;
        }
      }
    }

    return getNetworkTypeLegacy();
  }

  @SuppressWarnings("deprecation")
  private String getNetworkTypeLegacy() {
    android.net.NetworkInfo info = connectivityManager.getActiveNetworkInfo();
    if (info != null && info.isConnected()) {
      int type = info.getType();
      switch (type) {
        case ConnectivityManager.TYPE_BLUETOOTH:
          return CONNECTIVITY_BLUETOOTH;
        case ConnectivityManager.TYPE_ETHERNET:
          return CONNECTIVITY_ETHERNET;
        case ConnectivityManager.TYPE_WIFI:
        case ConnectivityManager.TYPE_WIMAX:
          return CONNECTIVITY_WIFI;
        case ConnectivityManager.TYPE_VPN:
          return CONNECTIVITY_VPN;
        case ConnectivityManager.TYPE_MOBILE:
        case ConnectivityManager.TYPE_MOBILE_DUN:
        case ConnectivityManager.TYPE_MOBILE_HIPRI:
          return CONNECTIVITY_MOBILE;
      }
    }

    return CONNECTIVITY_NONE;
  }

  public ConnectivityManager getConnectivityManager() {
    return connectivityManager;
  }
}
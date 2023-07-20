package dev.netPermissionHandler;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class ConnectivityMethodChannelHandler implements MethodChannel.MethodCallHandler {
  private final Connectivity connectivity;

  ConnectivityMethodChannelHandler(Connectivity connectivity) {
    assert (connectivity != null);
    this.connectivity = connectivity;
  }

  @Override
  public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
    if ("check".equals(call.method)) {
      result.success(connectivity.getNetworkType());
    } else {
      result.notImplemented();
    }
  }
}
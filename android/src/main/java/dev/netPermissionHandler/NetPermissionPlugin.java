package dev.netPermissionHandler;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import android.app.AlertDialog;

public class NetPermissionPlugin implements FlutterPlugin {
  private static final String CAMERA_PERMISSION = Manifest.permission.CAMERA;
  private static final int CAMERA_PERMISSION_REQUEST_CODE = 123; // Any unique value

  private MethodChannel methodChannel;
  private EventChannel eventChannel;
  private ConnectivityBroadcastReceiver receiver;
  private Context applicationContext;
  private MethodChannel cameraChannel; // New channel for camera access

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    setupChannels(binding.getBinaryMessenger(), binding.getApplicationContext());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    teardownChannels();
  }

  private void setupChannels(BinaryMessenger messenger, Context context) {
    applicationContext = context;
    methodChannel = new MethodChannel(messenger, "dev/connectivity");
    eventChannel = new EventChannel(messenger, "dev/connectivity_status");
    ConnectivityManager connectivityManager =
            (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

    Connectivity connectivity = new Connectivity(connectivityManager);

    ConnectivityMethodChannelHandler methodChannelHandler =
            new ConnectivityMethodChannelHandler(connectivity);
    receiver = new ConnectivityBroadcastReceiver(context, connectivity);

    methodChannel.setMethodCallHandler(methodChannelHandler);
    eventChannel.setStreamHandler(receiver);

    // Create a new channel for camera access
    cameraChannel = new MethodChannel(messenger, "dev/camera");
    cameraChannel.setMethodCallHandler(this::onCameraMethodCall);
  }

  private void teardownChannels() {
    methodChannel.setMethodCallHandler(null);
    eventChannel.setStreamHandler(null);
    receiver.onCancel(null);
    methodChannel = null;
    eventChannel = null;
    receiver = null;
  }

  public void requestCameraPermission(Activity activity) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      if (ActivityCompat.shouldShowRequestPermissionRationale(activity, CAMERA_PERMISSION)) {
        new AlertDialog.Builder(activity)
                .setTitle("Camera Permission Needed")
                .setMessage("This app needs the camera permission to take photos.")
                .setPositiveButton(
                        "OK",
                        new DialogInterface.OnClickListener() {
                          @Override
                          public void onClick(DialogInterface dialog, int which) {
                            ActivityCompat.requestPermissions(
                                    activity, new String[] {CAMERA_PERMISSION}, CAMERA_PERMISSION_REQUEST_CODE);
                          }
                        })
                .show();
      } else {
        ActivityCompat.requestPermissions(
                activity, new String[] {CAMERA_PERMISSION}, CAMERA_PERMISSION_REQUEST_CODE);
      }
    }
  }

  // Method for handling camera permission request from Flutter
  private void onCameraMethodCall(MethodCall call, MethodChannel.Result result) {
    switch (call.method) {
      case "requestCameraPermission":
        Activity activity = (Activity) applicationContext;
        if (activity != null) {
          requestCameraPermission(activity);
        } else {
          result.error("ACTIVITY_NULL", "Activity is null", null);
        }
        result.success(null);
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
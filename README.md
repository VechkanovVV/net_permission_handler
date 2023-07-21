
# NetPermissionHandler

## Project Description

NetPermissionHandler is an Android-exclusive plugin designed to handle network connectivity status on mobile devices, supporting both Wi-Fi and cellular connections. Its primary functionality includes checking the device's network connectivity, monitoring changes in the network status, and managing permissions for camera access. This plugin offers a seamless way for Android developers to ensure a smooth user experience while adhering to security and privacy best practices.
## Usage example


[Watch the video usage example](https://drive.google.com/file/d/1Wc6xGRr0YdGBirkdgY9lJ7E8TrYD0Rhq/view?usp=drive_link)

In the video demonstration, you can observe the practical application of the NetPermissionPlugin. The plugin serves the purpose of notifying users about any changes in their network connections, whether it's a switch between mobile data, Wi-Fi, or no connection at all. By utilizing the NetPermissionPlugin, developers can provide a seamless user experience by promptly alerting users to any network status changes, enabling them to stay informed about their connectivity at all times. This functionality ensures a more efficient and user-friendly interaction with the app, enhancing overall usability and satisfaction.
## How to Use

To use NetPermissionHandler in your project, follow these simple steps:

1. Install the NetPermissionHandler package via your preferred package manager.
2. In the pubspec.yaml of your project specify the path to the plugin and its name in the dependencies section. Example:
```
dependencies:
  flutter:
    sdk: flutter

  netPermissionHandler:
    path: ../
```
3. Add to your project
```
import 'package:netPermissionHandler/net_permission_handler.dart';
   ```
4. Start monitoring network connectivity changes and camera permissions status as required.

5. Also make sure that minSdkVersion = 16, if not put it into build.gradle:
```   

    defaultConfig {
        minSdkVersion 16
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }
   ```



## Features List

- Check network connectivity status (Wi-Fi and cellular).
- Monitor changes in network connectivity.
- Request and manage camera permission.

## Plugin methods that you can use
* ```checkConnection()``` - checking the network connection, the result of which is the string: "wifi" or "mobile" or "none"
* ```requestCameraPermission()``` - requests permission to use the camera, requests permission to use the camera, the result is the bool value (this is not properly working at the moment)

*  To check if the connection to network change, you may use this part of code:
```
NetPermissionHandler.startNetworkStatusListener((status) {
      setState(() {
        _connectionStatus = status;
      });
  }); 
```

## Frameworks or Technologies Used

- Java
- Android SDK
- Flutter
- Flutter SDK
- Dart
- Dart SDK

## Badges

[![NetPermissionHandler](https://img.shields.io/badge/NetPermissionHandler-v1.0-blue)](https://www.example.com/netpermissionhandler)

[![Dart](https://img.shields.io/badge/Dart-v2.14.4-blue)](https://dart.dev/)

[![Flutter](https://img.shields.io/badge/Flutter-v2.5-blue)](https://flutter.dev/)
## For Users

Thank you for choosing NetPermissionHandler! We are committed to providing you with a seamless experience in managing network connectivity and camera permissions in your mobile applications. If you encounter any issues or have any feature requests, please feel free to reach out to our support team. We value your feedback and will continue to improve NetPermissionHandler to meet your needs. Happy coding!
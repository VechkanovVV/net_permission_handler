import 'package:flutter/material.dart';
import 'dart:async';
import 'package:netPermissionHandler/net_permission_handler.dart';

class ConnectionStatusWidget extends StatefulWidget {
  @override
  _ConnectionStatusWidgetState createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  String _connectionStatus = 'Checking connection';

  @override
  void initState() {
    super.initState();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    NetPermissionHandler.startNetworkStatusListener((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connection Status: $_connectionStatus'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Request camera permission
                bool cameraPermissionGranted = await NetPermissionHandler.requestCameraPermission();
                if (cameraPermissionGranted) {
                  // Handle camera permission granted
                } else {
                  // Handle camera permission denied
                }
              },
              child: Text('Request Camera Permission'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: ConnectionStatusWidget(),
));
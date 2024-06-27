import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_test/internet_controller.dart';
import 'package:connectivity_test/network_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late NetworkController _networkController;
  late InternetController _internetController;

  @override
  void initState() {
    super.initState();
    _networkController = NetworkController.instance;
    _internetController = InternetController.instance;

    _networkController.init();
    _internetController.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connectivity Test',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<List<ConnectivityResult>>(
              stream: _networkController.connectionStatus,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data!;
                  final hasWifi = result.contains(ConnectivityResult.wifi);
                  final hasMobile = result.contains(ConnectivityResult.mobile);

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Wi-Fi: $hasWifi',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Mobile: $hasMobile',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            StreamBuilder<bool>(
              stream: _internetController.connectionStatusStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data!;

                  return Center(
                    child: Text(
                      'Internet: $result',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

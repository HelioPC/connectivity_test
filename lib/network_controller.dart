import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController {
  NetworkController._();

  static final NetworkController _instance = NetworkController._();
  static NetworkController get instance => _instance;

  final connectivity = Connectivity();

  final _connectionStatusController =
      StreamController<List<ConnectivityResult>>.broadcast();
  Stream<List<ConnectivityResult>> get connectionStatus =>
      _connectionStatusController.stream;

  Future<void> init() async {
    await connectivity.checkConnectivity().then((result) {
      _connectionStatusController.sink.add(result);
    });

    connectivity.onConnectivityChanged.listen((result) {
      _connectionStatusController.sink.add(result);
    });
  }
}

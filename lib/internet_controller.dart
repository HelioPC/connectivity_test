import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetController {
  InternetController._();

  static final InternetController _instance = InternetController._();
  static InternetController get instance => _instance;

  final _conectivity = InternetConnectionChecker();

  final _connectionStatusController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Future<void> init() async {
    await _conectivity.hasConnection.then((result) {
      _connectionStatusController.sink.add(result);
    });

    _conectivity.onStatusChange.listen((result) {
      _connectionStatusController.sink
          .add(result == InternetConnectionStatus.connected);
    });
  }
}

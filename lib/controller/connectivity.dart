import 'dart:async';

import 'package:aissam_store/view/public/connection_statue_warning_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ConnectivityController extends GetxController {
  static ConnectivityController get instance => Get.find();
  final Connectivity _connectivity = Connectivity();
  late final StreamController<bool> connectivityStream;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connectivityStream = StreamController.broadcast();
    _connectivity.onConnectivityChanged.listen((event) {
      final newEv = event != ConnectivityResult.none;
      connectivityStream.add(newEv);
      // if (Get.currentRoute != '/' && !newEv) {
      //   _showConnectionStatueSnackBar();
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    connectivityStream.done;
    super.dispose();
  }

  // void _showConnectionStatueSnackBar() {
  //   print('SHOW CONN SNACK BAR');
  //   ConnectionStatueWarningBar.snackBar();
  // }

  Future<bool> get checkConnectivity async {
    final connRes = await _connectivity.checkConnectivity();
    return connRes != ConnectivityResult.none;
  }

  // Stream<bool> _connectivityStream(){
  //   final StreamSubscription connectivityStream = _connectivity.onConnectivityChanged.listen((event) {
  //     if (event == ConnectivityResult.none)
  //   });
  //   return connectivityStream;
  // }
}

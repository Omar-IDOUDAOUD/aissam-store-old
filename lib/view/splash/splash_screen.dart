import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;

  bool _fetchingResulte = true;
  void _startFetchingData() async {
    print('_______1________');
    if (_authenticationService.userLoggedIn) {
      final UserController _userController = UserController.instance;
      await _userController.initializeData().then((value) {
        setState(() {
          _fetchingResulte = value;
        });
      });
      if (_fetchingResulte = false) return;
      print('________1.5_______');
    } else {
      await 1.seconds.delay();
    }
    print('________2_______');
    Get.toNamed('/onboarding/greeting');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startFetchingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Welcome to\nAISSAM STORE'),
          _fetchingResulte
              ? CircularProgressIndicator()
              : Text('check your conn and try again!.'),
        ],
      ),
    );
  }
}

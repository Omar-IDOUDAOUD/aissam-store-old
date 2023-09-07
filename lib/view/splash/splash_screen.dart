import 'package:aissam_store/bindings/authentication_service.dart';
import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/firebase_options.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _errorOccurred = false;

  _startFetchingData() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    AuthenticationServiceBinding().dependencies();
    final AuthenticationService authenticationService =
        AuthenticationService.instance;
    if (authenticationService.userLoggedIn) {
      final UserController userController = UserController.instance;
      try {
        await userController.initializeData();
      } catch (e) {
        setState(() {
          _errorOccurred = true;
        });
      }
    } else {
      await 1.seconds.delay();
    }
    if (!_errorOccurred) Get.offNamed('/onboarding/greeting');
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Welom to\nAISSAM STORE'),
            if (_errorOccurred)
              Text('Something went wrong!')
            else
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

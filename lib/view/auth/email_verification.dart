import 'package:aissam_store/services/auth/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final AuthenticationService _authService = AuthenticationService.instance;
  bool emailVerified = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startVerifying();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _authService.cancelEmailVerification();
    super.dispose();
  }

  void _startVerifying() async {
    _authService
        .cancelEmailVerification(); //to cancel the previous email verifiction proccess
    await _authService.startEmailVerification().then((value) {
      setState(() {
        emailVerified = value;
      });
    });
    if (emailVerified) {
      await 1.seconds.delay();
      Get.offAllNamed('/onboarding/user_info_customization');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Verivication"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('check your email!'),
          Text(
              'Waiting for verfy your email, if you did this page will redirect to home page'),
          if (!emailVerified)
            MaterialButton(
              onPressed: () =>
                  Get.offNamed('/onboarding/user_info_customization'),
              child: Text('skip email verification'),
            ),
          if (emailVerified)
            Text(
              'Email Verified!',
              style: TextStyle(color: Colors.green),
            ),
        ],
      ),
    );
  }
}

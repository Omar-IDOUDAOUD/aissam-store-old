import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final UserController _userController = UserController.instance;
  final AuthenticationService _authService = AuthenticationService.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(_userController.getUserFromAuth().userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Bar')),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {},
              child: Text('get data'),
            ),
            MaterialButton(
              onPressed: () async {
                await _authService.signOut();
                Get.offAllNamed('/authentication');
              },
              child: Text('log out'),
            ),
          ],
        ),
      ),
    );
  }
}//3IJcVXxTtYixGG6ABoKw  3PbcwdXLqDUvrjyw2o5e  4ZvfZlE3sr9VKpSf2suq  6FBs1BJVe6qHF3i916ZI

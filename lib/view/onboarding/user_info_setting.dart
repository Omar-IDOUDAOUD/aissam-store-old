// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/models/user.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:aissam_store/view/public/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingUserInfoSetting extends StatefulWidget {
  const OnBoardingUserInfoSetting({super.key});

  @override
  State<OnBoardingUserInfoSetting> createState() =>
      _OnBoardingUserInfoSettingState();
}

class _OnBoardingUserInfoSettingState extends State<OnBoardingUserInfoSetting> {
  final UserController _userController = UserController.instance;
  final AuthenticationService _authenticationService =
      AuthenticationService.instance;
  late UserModel _buildingUserModel;
  late final User _authenticatedUser;
  late final TextEditingController _firstNameCtrl,
      _lastNameCtrl,
      _phoneNumberCtrl;
  String? _photoUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticatedUser = _authenticationService.getUser;
    _firstNameCtrl =
        TextEditingController(text: _authenticatedUser.displayName);
    _lastNameCtrl = TextEditingController();
    _phoneNumberCtrl =
        TextEditingController(text: _authenticatedUser.phoneNumber);
    _photoUrl = _authenticatedUser.photoURL;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneNumberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                _photoUrl != null ? NetworkImage(_photoUrl!) : null,
            backgroundColor: Colors.pink,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _firstNameCtrl,
                  hint: 'First name',
                ),
              ),
              Expanded(
                child: CustomTextField(
                  controller: _lastNameCtrl,
                  hint: 'last name',
                ),
              ),
            ],
          ),
          CustomTextField(
            controller: _phoneNumberCtrl,
            hint: 'phone number',
          ),
          Spacer(),
           if (_isLoading) CircularProgressIndicator() , 
          if (_saveUserSuccess != null)
            if (_saveUserSuccess!)
              (Text('Save success'))
            else if (!_saveUserSuccess!)
              Text('save failed'),
          MaterialButton(
            child:Text('Save User'),
            onPressed: () {
              if (!_isLoading) _submitData();
            },
          ),
          MaterialButton(
            child: Text('Skip'),
            onPressed: () {
              if (!_isLoading) _submitData();
            },
          ),
        ],
      ),
    ));
  }

  void _submitData() async {
    _buildingUserModel = UserModel(
      userId: _authenticatedUser.uid,
      firstName: _firstNameCtrl.text,
      lastName: _lastNameCtrl.text,
      phoneNumber: _phoneNumberCtrl.text,
      profilePhotoUrl: _photoUrl,
      email: _authenticatedUser.email,
    );
    setState(() {
      _isLoading = true;
    });
    _saveUserSuccess = await _userController.saveUser(_buildingUserModel);
    setState(() {
      _isLoading = false;
    });
    if (_saveUserSuccess!) {
      await 100.milliseconds.delay();
      Get.offAllNamed('/');
    }
  }

  bool _isLoading = false;
  bool? _saveUserSuccess = null;
}

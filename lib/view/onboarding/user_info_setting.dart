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
  // final AuthenticationService _authenticationService =
  //     AuthenticationService.instance;
  UserModel? _buildingUserModel = null;
  // late final User _authenticatedUser;
  late final TextEditingController _firstNameCtrl,
      _lastNameCtrl,
      _phoneNumberCtrl;
  // String? _photoUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      child: FutureBuilder<UserModel>(
          initialData: _buildingUserModel,
          future: _buildingUserModel != null
              ? null
              : _userController.getUser().then((value) {
                  _buildingUserModel = value;
                  _firstNameCtrl =
                      TextEditingController(text: _buildingUserModel!.firstName)
                        ..addListener(() {
                          _buildingUserModel!.firstName = _firstNameCtrl.text;
                        });
                  _lastNameCtrl =
                      TextEditingController(text: _buildingUserModel!.lastName)
                        ..addListener(() {
                          _buildingUserModel!.lastName = _lastNameCtrl.text;
                        });
                  _phoneNumberCtrl = TextEditingController(
                      text: _buildingUserModel!.phoneNumber)
                    ..addListener(() {
                      _buildingUserModel!.phoneNumber = _phoneNumberCtrl.text;
                    });
                  return value;
                }),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('AN ERROR OCCURRED');
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            if (snapshot.hasData)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _buildingUserModel!.profilePhotoUrl != null
                        ? NetworkImage(_buildingUserModel!.profilePhotoUrl!)
                        : null,
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _categoriesController,
                          hint: 'insert category',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _categories.add(_categoriesController.text);
                          _categoriesController.text = '';
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (_isLoading) CircularProgressIndicator(),
                  if (_saveUserSuccess != null)
                    if (_saveUserSuccess!)
                      (Text('Save success'))
                    else if (!_saveUserSuccess!)
                      Text('save failed'),
                  MaterialButton(
                    child: Text('Save User'),
                    onPressed: () {
                      if (!_isLoading) _submitData();
                    },
                  ),
                  MaterialButton(
                    child: Text('Skip'),
                    onPressed: () {
                      if (!_isLoading) goNextPage();
                    },
                  ),
                ],
              );
            return Text('unhandeled exception');
          }),
    ));
  }

  final TextEditingController _categoriesController = TextEditingController();

  List<String> _categories = [];

  void _submitData() async {
    setState(() {
      _isLoading = true;
    });
    await _userController
        .saveUser(_buildingUserModel!, _categories)
        .catchError((e) {
      setState(() {
        _saveUserSuccess = false;
        _isLoading = false;
      });
      return;
    });
    setState(() {
      _saveUserSuccess = true;
      _isLoading = false;
    });

    await 1.seconds.delay();
    goNextPage();
  }

  void goNextPage() {
    Get.toNamed('/testing');
  }

  bool _isLoading = false;
  bool? _saveUserSuccess = null;
}

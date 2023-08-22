import 'package:aissam_store/services/auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class AuthenticationMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AuthenticationService.instance.userLoggenIn)
      return RouteSettings(name: '/');
    return super.redirect(route);
  }
}

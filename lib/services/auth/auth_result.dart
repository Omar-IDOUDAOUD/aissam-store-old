// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:aissam_store/services/auth/auth_failed_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  bool success = false;
  String? message;
  UserCredential? user;

  ///def: false
  bool emailWrong = false, userNameWrong = false, passwordWrong = false;
  String? emailWrongMsg, userNameWrongMsg, passwordWrongMsg;

  bool needsFillUserInfoAfterAuth = false;

  set setEmailWrongMsg(String? v) {
    emailWrongMsg = v;
    emailWrong = v != null;
  }

  set setUserNameWrongMsg(String? v) {
    userNameWrongMsg = v;
    userNameWrong = v != null && !userNameWrong;
  }

  set setPasswordWrongMsg(String? v) {
    passwordWrongMsg = v;
    passwordWrong = v != null && !passwordWrong;
  }

  // void resetClass() {
  //   success = false;
  //   message = null;
  //   user = null;
  //   setEmailWrongMsg = null;
  //   setUserNameWrongMsg = null;
  //   setPasswordWrongMsg = null;
  // }

  factory AuthResult.fromErrorCode(
      {required String code, required AuthenticationModes type}) {
    if (type == AuthenticationModes.CreateAccountWithEmailAndPassword) {
      switch (code) {
        case 'invalid-email':
          return AuthResult(
            emailWrongMsg: AuthErrors.EMAIL_ICORRECT_MSG,
          );
        case 'weak-password':
          return AuthResult(
            passwordWrongMsg: AuthErrors.PASSWORD_WEAK_MSG,
          );
        case 'email-already-in-use':
          return AuthResult(
            emailWrongMsg: AuthErrors.EMAIL_ALREADY_USED_MSG,
          );
      }
    } else if (type == AuthenticationModes.SignInWithEmailAndPassword) {
      switch (code) {
        case 'wrong-password':
          return AuthResult(
            passwordWrongMsg: AuthErrors.WRONG_PASSWORD,
          );
        case 'invalid-email':
          return AuthResult(
            emailWrongMsg: AuthErrors.EMAIL_ICORRECT_MSG,
          );
        case 'user-not-found':
          return AuthResult(
            message: AuthErrors.USER_NOTFOUND,
            emailWrong: true,
            passwordWrong: true,
          );
        case 'user-disabled':
          return AuthResult(
            message: AuthErrors.USER_DISABLED,
            emailWrong: true,
            passwordWrong: true,
          );
      }
    }
    return AuthResult.anErrorOccure();
  }

  factory AuthResult.success({UserCredential? user}) {
    return AuthResult(success: true, user: user);
  }

  factory AuthResult.anErrorOccure() {
    return AuthResult(
        message:
            'An error occured!'); //note: add internet connectivity check before every firebase connection;
  }

  AuthResult({
    this.success = false,
    this.message,
    this.user,
    emailWrongMsg,
    passwordWrongMsg,
    userNameWrongMsg,
    this.emailWrong = false,
    this.userNameWrong = false,
    this.passwordWrong = false,
  }) {
    if (!emailWrong) setEmailWrongMsg = emailWrongMsg;
    if (!passwordWrong) setPasswordWrongMsg = passwordWrongMsg;
    if (!userNameWrong) setUserNameWrongMsg = userNameWrongMsg;
  }
}

enum AuthenticationModes {
  Anonymous,
  CreateAccountWithEmailAndPassword,
  SignInWithEmailAndPassword,
}

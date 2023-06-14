import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const AissamStore());
}

class AissamStore extends StatelessWidget {
  const AissamStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            color: CstColors.a,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 26,
            // height: 1.3,
          ),
          headline2: TextStyle(
            color: CstColors.a,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            // height: 1,
          ),
          headline3: TextStyle(
            color: CstColors.c,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            // height: 1,
          ),
          headline4: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12.5,
            // height: 1,
          ),
          headline5: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            // height: 1,
          ),
        ),
      ),
      home: Home(),
    );
  }
}

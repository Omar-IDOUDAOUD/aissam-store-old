import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/view/fullscreen_image/fullscreen_image.dart';
import 'package:aissam_store/view/home/home.dart';
import 'package:aissam_store/view/product_dets/product_details.dart';
import 'package:aissam_store/view/testing/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          headlineLarge: TextStyle(
            //h1
            color: CstColors.a,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 26,
            // height: 1.3,
          ),
          headlineMedium: TextStyle(
            //h2
            color: CstColors.a,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            // height: 1,
          ),
          headlineSmall: TextStyle(
            //3
            color: CstColors.c,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            // height: 1,
          ),
          bodyLarge: TextStyle(
            //h4
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            // height: 1,
          ),
          bodyMedium: TextStyle(
            //h5
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 13,
            // height: 1,
          ),
          bodySmall: TextStyle(
            //h6
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 11.5,
            // height: 1,
          ),
          displayLarge: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 10.5,
            // height: 1,
          ),
          displayMedium: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 10,
            // height: 1,
          ),
          displaySmall: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 8.5,
            // height: 1,
          ),
        ),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/product_details',
          page: () => ProductDetails(),
          // transitionDuration: 400.milliseconds,
          transition: Transition.cupertino,
          // showCupertinoParallax: false,
          // maintainState:
        ),
        GetPage(
          name: '/fullscreen_image',
          page: () => FullScreenImage(),
          transition: Transition.fadeIn,
          showCupertinoParallax: false,
          opaque: false,
        ),
        GetPage(name: '/testing', page: () => TestPage()),
      ],
      initialRoute: '/home',
    );
  }
}

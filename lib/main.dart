import 'package:aissam_store/bindings/authentication_service.dart';
import 'package:aissam_store/bindings/home_controllers.dart';
import 'package:aissam_store/controller/connectivity.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/firebase_options.dart';
import 'package:aissam_store/middlewares/auth.dart';
import 'package:aissam_store/view/add_checkout_address/add_checkout_address.dart';
import 'package:aissam_store/view/auth/authentication.dart';
import 'package:aissam_store/view/auth/email_verification.dart';
import 'package:aissam_store/view/checkout/chackout.dart';
import 'package:aissam_store/view/fullscreen_image/fullscreen_image.dart';
import 'package:aissam_store/view/home/home.dart';
import 'package:aissam_store/view/onboarding/greeting/greeting.dart';
import 'package:aissam_store/view/onboarding/user_info_customization/user_info_customization.dart';
import 'package:aissam_store/view/product_dets/product_details.dart';
import 'package:aissam_store/view/public/connection_statue_warning_bar.dart';
import 'package:aissam_store/view/settings/account_info.dart';
import 'package:aissam_store/view/settings/addresses.dart';
import 'package:aissam_store/view/settings/appearence.dart';
import 'package:aissam_store/view/settings/notifications.dart';
import 'package:aissam_store/view/splash/splash_screen.dart';
import 'package:aissam_store/view/testing/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AissamStore());
}

class AissamStore extends StatelessWidget {
  AissamStore({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: CstColors.a,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 26,
          ),
          headlineMedium: TextStyle(
            color: CstColors.a,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          headlineSmall: TextStyle(
            color: CstColors.c,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
          bodyLarge: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          bodyMedium: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          bodySmall: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 11.5,
          ),
          displayLarge: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 10.5,
          ),
          displayMedium: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          displaySmall: TextStyle(
            color: CstColors.b,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 8.5,
          ),
        ),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          transition: Transition.cupertino,
          binding: HomeControllersBindings(),
        ),
        GetPage(
          name: '/product_details',
          page: () => ProductDetails(),
          transition: Transition.cupertino,
        ),
        GetPage(
            name: '/fullscreen_image',
            page: () => FullScreenImage(),
            transition: Transition.fadeIn,
            showCupertinoParallax: false,
            opaque: false),
        GetPage(
          name: '/testing',
          page: () => TestPage(),
          // binding: HomeControllersBindings()
        ),
        GetPage(name: '/checkout', page: () => CheckoutPage()),
        GetPage(
            name: '/add_checkout_address', page: () => AddCheckoutAddress()),
        GetPage(
            name: '/settings/account_info', page: () => SettingsAccountInfo()),
        GetPage(name: '/settings/appearence', page: () => SettingsAppearence()),
        GetPage(
            name: '/settings/notifications',
            page: () => SettingsNotifications()),
        GetPage(
            name: '/settings/user_addresses', page: () => SettingsAddresses()),
        GetPage(
          name: '/authentication',
          page: () => AuthenticationPage(),
        ),
        GetPage(
          name: '/onboarding/user_info_customization',
          page: () => OnBoardingUserInfoCustomizationPage(),
        ),
        GetPage(
          name: '/onboarding/greeting',
          page: () => OnBoardingGreetingPage(),
          middlewares: [
            AuthenticationMiddleware(), // to route '/' if checked middlewar
          ],
        ),
        GetPage(
          name: '/authentication/email_verification',
          page: () => EmailVerificationPage(),
        ),
        GetPage(
          name: '/splash_screen',
          page: () => SplashScreen(),
        ),
      ],
      initialRoute: '/testing',
      // initialBinding: AuthenticationServiceBinding(),
      enableLog: true,
      logWriterCallback: localLogWriter,
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    print("LOG WRITER: $text");
    // pass the message to your favourite logging package here
    // please note that even if enableLog: false log messages will be pushed in this callback
    // you get check the flag if you want through GetConfig.isLogEnable
  }
}

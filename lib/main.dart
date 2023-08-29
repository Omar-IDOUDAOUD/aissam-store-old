import 'package:aissam_store/bindings/authentication_service.dart';
import 'package:aissam_store/core/constants/colors.dart';
import 'package:aissam_store/firebase_options.dart';
import 'package:aissam_store/middlewares/auth.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:aissam_store/view/add_checkout_address/add_checkout_address.dart';
import 'package:aissam_store/view/auth/authentication.dart';
import 'package:aissam_store/view/checkout/chackout.dart';
import 'package:aissam_store/view/fullscreen_image/fullscreen_image.dart';
import 'package:aissam_store/view/home/home.dart';
import 'package:aissam_store/view/onboarding/user_info_setting.dart';
import 'package:aissam_store/view/product_dets/product_details.dart';
import 'package:aissam_store/view/settings/account_info.dart';
import 'package:aissam_store/view/settings/addresses.dart';
import 'package:aissam_store/view/settings/appearence.dart';
import 'package:aissam_store/view/settings/notifications.dart';
import 'package:aissam_store/view/testing/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        GetPage(name: '/testing', page: () => TestPage()),
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
          middlewares: [
            AuthenticationMiddleware(), // to route '/' if checked middleware
          ],
        ),
        GetPage(
          name: '/onboarding/user_info_setting',
          page: () => OnBoardingUserInfoSetting(),
        ),
      ],
      initialRoute: '/authentication',
      initialBinding: AuthenticationServiceBinding(),
    );
  }
}

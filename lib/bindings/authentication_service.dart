 
import 'package:aissam_store/controller/user.dart';
import 'package:aissam_store/services/auth/authentication.dart';
import 'package:get/get.dart';

class AuthenticationServiceBinding extends Bindings {
  @override
  void dependencies() {
    print('inject AuthenticationService to dependencie');
    Get.put(AuthenticationService(), permanent: true);
    Get.lazyPut(() =>
        UserController(), fenix: true); // lazy put in case the user sign in with email and address, in this case no need to user ctrl on auth page,
  }
}

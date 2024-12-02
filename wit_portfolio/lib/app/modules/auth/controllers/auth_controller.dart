import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLogin = true.obs;
  
  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
  }

  Future<void> signIn(String email, String password) async {
    // TODO: Implement Firebase authentication
  }

  Future<void> signUp(String email, String password) async {
    // TODO: Implement Firebase authentication
  }
}

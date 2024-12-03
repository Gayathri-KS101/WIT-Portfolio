import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final _auth = FirebaseAuth.instance;
  
  // Selected section index
  final RxInt selectedIndex = 0.obs;
  
  // User info
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  void changeSection(int index) {
    selectedIndex.value = index;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/auth');
  }
}

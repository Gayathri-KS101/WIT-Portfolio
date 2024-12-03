import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final isLogin = true.obs;
  final isLoading = false.obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }
  
  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed('/home'); // Navigate to home after successful login
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Create user document in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'createdAt': Timestamp.now(),
        'lastLogin': Timestamp.now(),
        'progress': {
          'completedModules': [],
          'currentModule': null,
        }
      });
      
      Get.offAllNamed('/home'); // Navigate to home after successful signup
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for this email.';
      }
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/'); // Navigate back to landing page
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Update user progress
  Future<void> updateProgress({
    required String moduleId,
    required bool completed,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      await _firestore.collection('users').doc(userId).update({
        'progress.currentModule': moduleId,
        if (completed) 'progress.completedModules': FieldValue.arrayUnion([moduleId]),
        'lastUpdated': Timestamp.now(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update progress', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Get user progress
  Future<Map<String, dynamic>?> getUserProgress() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return null;

      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?['progress'] as Map<String, dynamic>?;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch progress', snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
}

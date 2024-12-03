import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  AuthView({Key? key}) : super(key: key) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1B4D3E),
              Color(0xFF2A6B55),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.isLogin.value ? 'Welcome Back' : 'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4D3E),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    controller.isLogin.value 
                      ? 'Sign in to continue your journey'
                      : 'Join us to start your journey',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  if (!controller.isLogin.value) ...[
                    SizedBox(height: 20),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                  ],
                  SizedBox(height: 30),
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (controller.isLogin.value) {
                            await controller.signIn(
                              emailController.text,
                              passwordController.text,
                            );
                          } else {
                            if (passwordController.text != confirmPasswordController.text) {
                              Get.snackbar(
                                'Error',
                                'Passwords do not match',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            await controller.signUp(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B4D3E),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: controller.isLoading.value
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(controller.isLogin.value ? 'Sign In' : 'Sign Up'),
                  )),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      controller.toggleAuthMode();
                      // Clear fields when switching modes
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                    },
                    child: Text(
                      controller.isLogin.value
                        ? 'Don\'t have an account? Sign up'
                        : 'Already have an account? Sign in',
                      style: TextStyle(color: Color(0xFF2A6B55)),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // If the user is not logged in and trying to access a protected route,
    // redirect them to the auth page
    if (FirebaseAuth.instance.currentUser == null && 
        route != '/auth' && 
        route != '/') {
      return const RouteSettings(name: '/auth');
    }
    
    // If the user is logged in and trying to access auth page,
    // redirect them to home
    if (FirebaseAuth.instance.currentUser != null && 
        (route == '/auth' || route == '/')) {
      return const RouteSettings(name: '/home');
    }
    
    return null;
  }
}

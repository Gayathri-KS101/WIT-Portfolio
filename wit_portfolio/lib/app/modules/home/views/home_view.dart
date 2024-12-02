import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1B4D3E), // Dark pastel green
              Color(0xFF2A6B55), // Lighter pastel green
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Navigation Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WIT GEC',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => Get.toNamed('/auth'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF1B4D3E),
                          ),
                          child: Text('Login'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => Get.toNamed('/auth'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2A6B55),
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Hero Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 60.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Women in Tech GEC Palakkad',
                          textStyle: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Empowering women in technology through community, education, and innovation.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Open Mic Section
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'O-penmic Session 5/8',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4D3E),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Open discussion for girls to talk more about tech and projects in groups within campus',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Placeholder for Women in Tech Images
              // TODO: Add image carousel here
              Container(
                height: 300,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Image Gallery Coming Soon',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WIT Portfolio',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF1B4D3E),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: controller.signOut,
          ),
        ],
      ),
      body: Row(
        children: [
          // Navigation Rail
          NavigationRail(
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: controller.changeSection,
            labelType: NavigationRailLabelType.all,
            backgroundColor: Color(0xFF1B4D3E),
            selectedIconTheme: IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.white70),
            selectedLabelTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle: GoogleFonts.poppins(
              color: Colors.white70,
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.chat),
                label: Text('Chat Room'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                label: Text('Learn'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.smart_toy),
                label: Text('AI Chat'),
              ),
            ],
          ),
          
          // Main Content Area
          Expanded(
            child: Obx(() {
              switch (controller.selectedIndex.value) {
                case 0:
                  return Center(
                    child: Text(
                      'Chat Room Coming Soon',
                      style: GoogleFonts.poppins(fontSize: 24),
                    ),
                  );
                case 1:
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Portfolio Development Guide',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Choose Your Path:',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            children: [
                              _buildPathCard(
                                'Beginner',
                                'HTML, CSS, JavaScript',
                                'Perfect for getting started with web development',
                                Icons.star,
                              ),
                              SizedBox(height: 20),
                              _buildPathCard(
                                'Intermediate',
                                'React, Flutter',
                                'Advanced frameworks for modern applications',
                                Icons.code,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                case 2:
                  return Center(
                    child: Text(
                      'AI Chat Coming Soon',
                      style: GoogleFonts.poppins(fontSize: 24),
                    ),
                  );
                default:
                  return Container();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPathCard(String title, String technologies, String description, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Color(0xFF1B4D3E)),
                SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              technologies,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

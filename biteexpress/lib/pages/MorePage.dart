import 'package:biteexpress/pages/AboutUs.dart';
import 'package:biteexpress/pages/ContactUs.dart';
import 'package:biteexpress/pages/FAQ.dart';
import 'package:flutter/material.dart';
import './ProfilePage.dart';
import 'addProduct.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: ListView(
        children: [
          _buildNavigationItem(
            text: 'Profile',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage1()),
              );
            },
          ),
          _buildNavigationItem(
            text: 'Add Product', // Button to navigate to AddProductPage
            icon: Icons.add,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              );
            },
          ),
          _buildNavigationItem(
            text: 'Contact Us',
            icon: Icons.contact_emergency,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsApp()),
              );
            },
          ),
          _buildNavigationItem(
            text: 'FAQ',
            icon: Icons.help_center,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQApp()),
              );
            },
          ),
          _buildNavigationItem(
            text: 'About Us',
            icon: Icons.info,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          _buildNavigationItem(
            text: 'Settings',
            icon: Icons.settings,
            onTap: () {
              // Add navigation logic for Settings
            },
          ),
          _buildNavigationItem(
            text: 'Sign Out',
            icon: Icons.exit_to_app,
            onTap: () {
              // Add sign out logic
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MorePage(),
  ));
}

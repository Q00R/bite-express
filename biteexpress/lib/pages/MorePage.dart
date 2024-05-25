import 'package:flutter/material.dart';
import './ProfilePage.dart';
import 'addProduct.dart'; // Import the AddProductPage

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: ListView(
        children: [
          // _buildNavigationItem(
          //   text: 'Home',
          //   icon: Icons.home,
          //   onTap: () {
          //     // Add navigation logic for Home
          //   },
          // ),
          // _buildNavigationItem(
          //   text: 'Search',
          //   icon: Icons.search,
          //   onTap: () {
          //     // Add navigation logic for Search
          //   },
          // ),
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
            text: 'Settings',
            icon: Icons.settings,
            onTap: () {
              // Add navigation logic for Settings
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
            text: 'Sign Out',
            icon: Icons.exit_to_app,
            onTap: () {
              // Add sign out logic
            },
          ),
          _buildNavigationItem(
            text: 'Contacy Us',
            icon: Icons.contact_emergency,
            onTap: () {
              // Add sign out logic
            },
          ),
          _buildNavigationItem(
            text: 'Help',
            icon: Icons.help_center,
            onTap: () {
              // Add sign out logic
            },
          ),
          _buildNavigationItem(
            text: 'About',
            icon: Icons.info,
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

import 'package:flutter/material.dart';

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
            text: 'Home',
            icon: Icons.home,
            onTap: () {
              // Add navigation logic for Home
            },
          ),
          _buildNavigationItem(
            text: 'Search',
            icon: Icons.search,
            onTap: () {
              // Add navigation logic for Search
            },
          ),
          _buildNavigationItem(
            text: 'Profile',
            icon: Icons.person,
            onTap: () {
              // Add navigation logic for Profile
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

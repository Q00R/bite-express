import 'package:biteexpress/classes/user.dart';
import 'package:biteexpress/providers/authenticationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addProduct.dart';
import 'ProfilePage.dart';
import 'AboutUs.dart';
import 'ContactUs.dart';
import 'FAQ.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    return FutureBuilder<User?>(
      future: authProvider.getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading user information'));
        } else if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
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
                if (user.userType == 'Vendor')
                  _buildNavigationItem(
                    text: 'Add Product',
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
                  onTap: () {},
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No user information available'));
        }
      },
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
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthenticationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MorePage(),
      ),
    ),
  );
}

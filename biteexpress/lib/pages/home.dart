import 'package:biteexpress/pages/LoginOrSignUpScreen.dart';
import 'package:flutter/material.dart';
import '../widgets/categoryList.dart';
import '../widgets/homeCarousel.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.cookie_outlined,
              color: Colors.orange,
            ),
            SizedBox(width: 8),
            Text(
              'Bite Express',
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.login), // replace with your preferred icon
            onPressed: () {
              // replace isLoggedIn with your actual condition to check if user is logged in
              if (false) {
                // perform logout operation
              } else {
                // perform login operation // navigate to login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              color: Colors.orange.shade100,
              child: const Row(
                children: [
                  Text(
                    'Bite Express Now, in 60 mins',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.cookie_outlined, color: Colors.orange, size: 15),
                ],
              ),
            ),
            const SizedBox(height: 2),
            CarouselWithAutoplay(),
            CategoryList(),
          ],
        ),
      ),
    );
  }
}

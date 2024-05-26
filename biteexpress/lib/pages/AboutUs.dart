import 'package:biteexpress/main.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Text(
            'Welcome to our e-commerce platform, where we specialize in providing high-quality food products directly to your door. Our mission is to make it easy and convenient for you to enjoy fresh, delicious food without the hassle of shopping in-store. We source our products from trusted suppliers to ensure that you receive the best quality possible. Whether you are looking for fresh produce, gourmet items, or everyday staples, we have everything you need. Our dedicated team is committed to providing exceptional customer service and ensuring that your shopping experience is seamless and enjoyable. Thank you for choosing our platform for your food shopping needs. We look forward to serving you!',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

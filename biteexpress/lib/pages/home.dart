import 'package:flutter/material.dart';
import '../widgets/categoryList.dart';
import '../widgets/homeCarousel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          children: [
            Icon(
              Icons.cookie_outlined,
              color: Colors.orange,
            ),
            SizedBox(width: 8),
            Text(
              'Bite Express',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24, // Increased font size for more presence
                fontWeight: FontWeight.bold, // Bold font weight for emphasis
              ),
            ),
          ],
        ),
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
                      fontSize: 16, // Increased font size for more presence
                      fontWeight: FontWeight.bold, // Bold font weight for emphasis
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.cookie_outlined, color: Colors.orange, size: 20), // Increased icon size for more presence
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

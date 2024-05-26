import 'package:flutter/material.dart';

class FAQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAQ',
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FAQPage(),
    );
  }
}

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqs = [
    FAQItem(
      question: 'Do you deliver to my area?',
      answer:
          'We currently deliver to select areas. You can check if we deliver to your area by entering your address during the checkout process.',
    ),
    FAQItem(
      question: 'What are your delivery hours?',
      answer:
          'Our delivery hours vary depending on your location and the day of the week. You can view available delivery slots during the checkout process.',
    ),
    FAQItem(
      question: 'Can I modify my order after it has been placed?',
      answer:
          'Unfortunately, we are unable to modify orders once they have been placed. However, you can cancel your order and place a new one with the desired modifications.',
    ),
    FAQItem(
      question: 'Are the food items fresh?',
      answer:
          'Yes, all our food items are sourced fresh and are of the highest quality. We ensure that our products meet strict quality standards.',
    ),
    FAQItem(
      question: 'Do you offer refunds?',
      answer:
          'We offer refunds for items that are damaged or spoiled. Please contact our customer support team within 24 hours of receiving your order to request a refund.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index].question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  faqs[index].answer,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}

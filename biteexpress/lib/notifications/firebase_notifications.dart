import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initFirebase() async {
    print("Initializing Firebase notifications...");

    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      String? token = await _firebaseMessaging.getToken();
      print('Firebase Messaging Token: $token');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received message while in foreground: ${message.notification?.title}, ${message.notification?.body}');
        // Handle foreground message here
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message clicked!');
        // Handle notification click here
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

// send notification once user add product to cAart say product added 
  Future<void> sendProductViewNotification(String title) async {
    print('Sending product view notification...');

    await _firebaseMessaging.subscribeToTopic('product_view');

    await _firebaseMessaging.send(
      RemoteMessage(
        data: {
          'title': title,
          'body': 'User viewed a product',
        },
        notification: Notification(
          title: title,
          body: 'User viewed a product',
        ),
        topic: 'product_view',
      ),
    );
  }
}

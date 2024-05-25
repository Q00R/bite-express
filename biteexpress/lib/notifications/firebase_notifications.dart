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

  Future<void> sendProductViewNotification(String productName) async {
    // You can use Firebase Cloud Messaging to send a push notification
    // Here you can call your backend service to send the notification
    // For demonstration purposes, let's just print the message
    print('User viewed product: $productName');

    // Your backend logic to send notification goes here
  }
}

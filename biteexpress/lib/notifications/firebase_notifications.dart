import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<void> sendNotification(   String title ) async {
      String? token = await _firebaseMessaging.getToken();

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'to':  token,
      'notification': {
        'title': title,
 
      },
      'priority': 'high',
    };

    // Send a POST request to FCM endpoint
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AIzaSyApM1zNsqZK8E_-uWpy1De6JIlLa0poIw4',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }

} 


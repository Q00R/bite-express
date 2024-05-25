import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String userType,
  }) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyApM1zNsqZK8E_-uWpy1De6JIlLa0poIw4');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      if (response.statusCode == 200) {
        _isAuthenticated = true;
        notifyListeners();

        var decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final userId = decodedResponse['localId'];

        // Save user information to the database
        await saveUserInfoToDatabase(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            userType: userType);

        print("token=" + decodedResponse['idToken']);
        print("Expires=" + decodedResponse['expiresIn']);
        print("local ID=" + decodedResponse['localId']);
      } else {
        print('Failed to sign up: ${response.statusCode}');
        throw Exception('Failed to sign up');
      }
    } catch (err) {
      print('Error: $err');
      throw err;
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String em, required String pass}) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyApM1zNsqZK8E_-uWpy1De6JIlLa0poIw4');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': em,
            'password': pass,
            'returnSecureToken': true,
          },
        ),
      );

      if (response.statusCode == 200) {
        _isAuthenticated = true;
        notifyListeners();
        var decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        print("token=" + decodedResponse['idToken']);
        print("Expires=" + decodedResponse['expiresIn']);
        print("local ID=" + decodedResponse['localId']);
      } else {
        print('Failed to sign in: ${response.statusCode}');
        throw Exception('Failed to sign in');
      }
    } catch (err) {
      print('Error: $err');
      throw err;
    }
  }

  Future<void> signOut() async {
    // Implement sign-out logic here
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> saveUserInfoToDatabase(
      {required String userId,
      required String firstName,
      required String lastName,
      required String phone,
      required String userType}) async {
    final databaseUrl =
        'https://bite-express-b3634-default-rtdb.firebaseio.com/users/$userId.json';

    try {
      final response = await http.put(
        Uri.parse(databaseUrl),
        body: json.encode({
          'firstname': firstName,
          'lastname': lastName,
          'phone': phone,
          'userType': userType
        }),
      );

      if (response.statusCode == 200) {
        print('User information saved successfully');
      } else {
        print('Failed to save user information: ${response.statusCode}');
        throw Exception('Failed to save user information');
      }
    } catch (err) {
      print('Error: $err');
      throw err;
    }
  }
}

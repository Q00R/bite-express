import 'dart:convert';
import 'package:biteexpress/classes/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthenticationProvider with ChangeNotifier {
  // Singleton instance
  static final AuthenticationProvider _instance =
      AuthenticationProvider._internal();

  factory AuthenticationProvider() {
    return _instance;
  }

  AuthenticationProvider._internal();

  bool _isAuthenticated = false;
  String? _authToken;

  bool get isAuthenticated => _isAuthenticated;
  String? get authToken => _authToken;

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
        var decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final userId = decodedResponse['localId'];

        await saveUserInfoToDatabase(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            userType: userType,
            email: email);

        _authToken = decodedResponse['localId'];
        _isAuthenticated = true;
        notifyListeners();

        print("token=" + _authToken!);
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

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyApM1zNsqZK8E_-uWpy1De6JIlLa0poIw4');

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
        var decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        _authToken = decodedResponse['localId'];
        _isAuthenticated = true;
        notifyListeners();

        print("token=" + _authToken!);
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
    _isAuthenticated = false;
    _authToken = null;
    notifyListeners();
  }

  Future<void> saveUserInfoToDatabase({
    required String userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String userType,
  }) async {
    final databaseUrl =
        'https://bite-express-b3634-default-rtdb.firebaseio.com/users/$userId.json';

    try {
      final response = await http.put(
        Uri.parse(databaseUrl),
        body: json.encode({
          'firstname': firstName,
          'lastname': lastName,
          'phone': phone,
          'userType': userType,
          'email': email
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

  Future<User?> getUserInfo() async {
    String? userId = _authToken;
    if (userId == null) {
      print('User ID not found in token.');
      return null;
    }

    final url = Uri.parse(
        'https://bite-express-b3634-default-rtdb.firebaseio.com/users/$userId.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final userInfo = json.decode(response.body) as Map<String, dynamic>;
        return User(
            firstname: userInfo['firstname'],
            lastname: userInfo['lastname'],
            phone: userInfo['phone'],
            userType: userInfo['userType'],
            email: userInfo['email'],
            userId: userId);
      } else {
        print('Failed to fetch user info: ${response.statusCode}');
        return null;
      }
    } catch (err) {
      print('Error: $err');
      return null;
    }
  }
}

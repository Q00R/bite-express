import 'package:biteexpress/main.dart';
import 'package:biteexpress/pages/SignIn.dart';
import 'package:biteexpress/providers/authenticationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home.dart'; // Import the home screen

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter email and password';
      });
      return;
    }

    try {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .signUpWithEmailAndPassword(em: email, pass: password);
      setState(() {
        _errorMessage = 'Sign up successful!';
      });
      // Navigate to home screen after successful sign-up
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainAppScaffold()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Sign up failed. Please check your email and password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInWidget()),
                );
              },
              child: Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcase/services/authService.dart';
import 'package:riverpodcase/view/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userModel.dart';
import '../services/sharedPrefencesService.dart';

class LogInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  Future<void> loginUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);

    if (emailError != null) {
      _showDialog(context, emailError);
    } else if (passwordError != null) {
      _showDialog(context, passwordError);
    } else {
      AuthService.login(email, password);
      String? token = await AuthService.login(email, password);
      print(token);
      TokenService.saveStringData(token!);

      var data = await TokenService.getStringData();
      print('data $data');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }


  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email address is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _showDialog(BuildContext context, String message) {
    // Hata mesajını kullanıcıya göstermek için bir dialog gösterilebilir
    print('Error: $message');
  }
}

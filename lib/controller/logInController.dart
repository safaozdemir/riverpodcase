
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
      //_showDialog(context, emailError);
    } else if (passwordError != null) {
      //_showDialog(context, passwordError);
    } else {
      AuthService.login(email, password);
      String? token = await AuthService.login(email, password);
      print(token);
      TokenService.saveStringData(token!);

      var data = await TokenService.getStringData();
      print('data $data');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }


  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      //ShowToast(context as BuildContext, 'Email address is required');
      return null;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      //ShowToast(context as BuildContext, 'Email a valid email address');
      return null;
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      //_showToast(context, 'Email a valid email address');
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.yellow,
        duration: Duration(seconds: 2),
        content: Text(
          '${message ?? ''}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'KAPAT',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcase/main.dart';
import 'package:riverpodcase/services/sharedPrefencesService.dart';

import '../controller/logInController.dart';


class LogInView extends StatelessWidget {
  LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final controller = LogInController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff18141c),
        title: Text(
          'log in',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff18141c),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            LogInEmailTextField(
              controller: controller.emailController,
              label: 'Email Address',
              hintText: 'Enter Your Email Address',
              obscureText: false,
            ),
            SizedBox(height: screen.height * 0.04),
            LogInEmailTextField(
              controller: controller.passwordController,
              label: 'Password',
              hintText: 'Enter Your Password',
              obscureText: true,
            ),
            SizedBox(height: screen.height * 0.04),
            ElevatedButton(
              onPressed: () async {
                controller.loginUser(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screen.width * 0.9, screen.height * 0.07),
                primary: Colors.yellow.shade700,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Colors.yellow.shade700,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "Log In",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}

class LogInEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;

  LogInEmailTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '$label',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xff28242c),
              focusColor: Color(0xff28242c),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: "$hintText",
            ),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}


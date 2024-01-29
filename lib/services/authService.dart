import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {'email': username, 'password': password},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'];
      return token;
    } else if (response.statusCode == 400) {
      var data = jsonDecode(response.body);
      String error = data['error'];
      print('Login Error: $error');
      return null;
    } else {
      print('LOGIN - UNSUCCESSFUL');
      return null;
    }
  }
}
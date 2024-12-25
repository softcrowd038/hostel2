// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:accident/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<void> loginStudent(
      BuildContext context, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('$baseUrl/profile/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        await sharedPreferences.setString('auth_token', responseBody['token']);
        await sharedPreferences.setString('user_uuid', responseBody['uuid']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You logged in successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        final responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(responseBody['error'] ?? 'An unknown error occurred')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isRemoved = await sharedPreferences.remove('auth_token');
    if (isRemoved == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }
}

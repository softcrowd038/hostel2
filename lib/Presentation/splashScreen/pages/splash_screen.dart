// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/login_and_registration/pages/login_registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        navigationWidget();
      }
    });
  }

  void navigationWidget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? authToken = sharedPreferences.getString('auth_token');

    if (authToken != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image(
          image: AssetImage("assets/images/hostel.png"),
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}

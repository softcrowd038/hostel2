// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:accident/Presentation/Emergency/Models/profile_model.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/scanner/services/sms_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EmergencyScreen();
}

class _EmergencyScreen extends State<EmergencyScreen> {
  StudentProfile? studentProfile;

  @override
  void initState() {
    super.initState();
    _fetchStudentProfile();
  }

  Future<void> _fetchStudentProfile() async {
    if (!mounted) return;
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final uuid = sharedPreferences.getString('user_uuid');
      if (uuid == null) throw Exception('User UUID not found');
      final provider =
          Provider.of<StudentProfileProvider>(context, listen: false);
      final profile = await provider.fetchStudentProfile(uuid);
      if (mounted) {
        setState(() {
          studentProfile = profile;
        });
      }
    } catch (e) {
      print('Error fetching student profile: $e');
    }
  }

  void requestPermissions() async {
    try {
      final bool? result = await Telephony.instance.requestSmsPermissions;
      if (result == true) {
        print("SMS permission granted");
      } else {
        print("SMS permission denied");
      }
    } catch (e) {
      print('Error requesting permissions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    SMSService smsService = SMSService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.5,
              child: Image.network(
                  'https://img.freepik.com/free-vector/emergency-call-concept-illustration_114360-6864.jpg'),
            ),
            Text(
              'Emergency',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: screenHeight * 0.024,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.018),
              child: Text(
                'Press the below button in case of emergency. It will share your live location with your parents.',
                style: TextStyle(
                    color: const Color.fromARGB(255, 161, 161, 161),
                    fontSize: screenHeight * 0.015),
              ),
            ),
            GestureDetector(
              onTap: () {
                smsService.sendEmergencySMS(studentProfile, context);
              },
              child: Padding(
                padding: EdgeInsets.all(screenHeight * 0.015),
                child: Container(
                  height: screenHeight * 0.05,
                  width: screenWidth,
                  color: const Color.fromARGB(255, 221, 15, 0),
                  child: Center(
                    child: Text(
                      'Press',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.018),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

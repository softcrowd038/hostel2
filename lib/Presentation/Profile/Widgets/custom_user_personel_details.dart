// ignore_for_file: avoid_print

import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class CustomUserPersonalDetails extends StatefulWidget {
  const CustomUserPersonalDetails({Key? key}) : super(key: key);

  @override
  State<CustomUserPersonalDetails> createState() =>
      _CustomUserPersonalDetailsState();
}

class _CustomUserPersonalDetailsState extends State<CustomUserPersonalDetails> {
  ProfilePageModel? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      ProfilePageModel? userData =
          await FireStoreProfileData().getUserData(email);
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _userData != null
        ? Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Personal Details",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.email ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.apartment,
                    size: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _userData!.address ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.phone_android,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.phone ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person_2,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.emergencyContactName ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.group,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.relation ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.emergency,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.emergencyPhone ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.cake,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.birthdate.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.male,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userData!.gender ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Center(
            child: Transform.scale(
            scale: 0.1,
            child: LiquidCircularProgressIndicator(
              value: 0.5, // The progress value (0.0 - 1.0)
              valueColor: const AlwaysStoppedAnimation(Colors.yellow),
              backgroundColor: Colors.black,
              borderColor: Colors.yellow,
              borderWidth: 1.0,
              direction: Axis.vertical, // or Axis.horizontal
            ),
          )); // Show a loading indicator while data is being fetched
  }
}

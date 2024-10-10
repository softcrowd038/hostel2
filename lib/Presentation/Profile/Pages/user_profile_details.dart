import 'dart:io';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/edit_profile.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_user_personel_details.dart';
import 'package:accident/Presentation/login_and_registration/Services/auth_session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
      if (userData != null) {
        setState(() {
          _userData = userData;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _userData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) => Stack(
                  children: [
                    const Divider(
                      color: Colors.orange,
                      thickness: 2,
                    ),
                    if (_userData != null)
                      Positioned(
                        top: orientation == Orientation.portrait ? 100 : 70,
                        left: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.width / 2 - 70
                            : MediaQuery.of(context).size.width / 7 - 70,
                        child: Hero(
                          tag: 'user_avatar',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: orientation == Orientation.portrait
                                  ? BorderRadius.circular(70)
                                  : BorderRadius.circular(100),
                            ),
                            child: CircleAvatar(
                              radius: orientation == Orientation.portrait
                                  ? 70
                                  : 100,
                              backgroundImage:
                                  FileImage(File(_userData!.imageurl ?? '')),
                            ),
                          ),
                        ),
                      ),
                    if (_userData != null)
                      Positioned(
                        top: 250.0,
                        left: MediaQuery.of(context).size.width / 3.3,
                        child: Center(
                          child: Text(
                            _userData!.name ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal,
                          ),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CustomUserPersonalDetails(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: OrientationBuilder(
        builder: (context, orientation) => Stack(
          children: [
            Positioned(
              right: 0,
              bottom: orientation == Orientation.portrait ? 120 : 70,
              child: FloatingActionButton(
                heroTag: 'edit_button', // Unique tag for the edit button
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileDetails(),
                    ),
                  );
                },
                elevation: 2,
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: orientation == Orientation.portrait ? 50 : 140,
              child: FloatingActionButton(
                heroTag: 'logout_button', // Unique tag for the logout button
                onPressed: () {
                  Provider.of<AuthSessionProvider>(context, listen: false)
                      .logout(context);
                },
                elevation: 2,
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

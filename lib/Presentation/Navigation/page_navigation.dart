import 'dart:io';
import 'package:accident/Presentation/Accident_Detection/Pages/get_data.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/user_profile_details.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/dashboard/pages/home_page.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    const MainPage(),
    const AccidentListWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 199, 130),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 253, 228, 1)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome !",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    if (_userData != null)
                      Consumer<UserCredentials>(
                        builder: (context, userCredentials, child) {
                          return Text(
                            "${_userData!.name ?? ''} ",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const UserProfilePage()),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: _userData == null
                    ? const CircularProgressIndicator(
                        color: Colors.yellow,
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            _userData != null && _userData!.imageurl != null
                                ? FileImage(File(_userData!.imageurl!))
                                : null,
                      ),
              ),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        elevation: 5,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

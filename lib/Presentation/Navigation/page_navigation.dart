// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:accident/Presentation/Emergency/Models/profile_model.dart';
import 'package:accident/Presentation/Emergency/Pages/emergency_screen.dart';
import 'package:accident/Presentation/Emergency/Pages/hostel_fees.dart';
import 'package:accident/Presentation/Emergency/Profile/profile_page.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/dashboard/pages/home_page.dart';
import 'package:accident/Presentation/login_and_registration/Services/api_service.dart';
import 'package:accident/Presentation/scanner/pages/scanner_page.dart';
import 'package:accident/Presentation/scanner/services/sms_service.dart';
import 'package:accident/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  ApiService apiService = ApiService();
  StudentProfile? studentProfile;

  final List<Widget> _widgetOptions = <Widget>[
    const MainPage(),
    const ScannerPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchStudentProfile();
  }

  Future<void> _fetchStudentProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final uuid = sharedPreferences.getString('user_uuid');
    final provider =
        Provider.of<StudentProfileProvider>(context, listen: false);
    final profile = await provider.fetchStudentProfile(uuid!);
    setState(() {
      studentProfile = profile;
    });
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
    SMSService smsService = SMSService();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  smsService.sendEmergencySMS(studentProfile, context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.035,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.002)),
                  child: Center(
                    child: Text(
                      'help',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 221, 15, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        '$baseUrl/student_regi/${studentProfile?.profilePic}'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${studentProfile?.firstName} ${studentProfile?.lastName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Room: ${studentProfile?.roomNumber}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.emergency),
              title: const Text('Emergency'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmergencyScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Hostel Fees'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HostelFees()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log Out'),
              onTap: () {
                apiService.logout(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: _selectedIndex,
        onTap: _onItemTapped,
        circleColor:
            const Color.fromARGB(255, 221, 15, 0), 
        activeIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.qr_code_scanner, color: Colors.white),
          Icon(Icons.person_pin, color: Colors.white),
        ],
        inactiveIcons: const [
          Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 255)),
          Icon(Icons.qr_code_scanner,
              color: Color.fromARGB(255, 255, 255, 255)),
          Icon(Icons.person_pin, color: Color.fromARGB(255, 255, 255, 255)),
        ],
        color: const Color.fromARGB(255, 0, 0, 0),
        height: 60,
        circleWidth: 60,
        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
      ),
    );
  }
}

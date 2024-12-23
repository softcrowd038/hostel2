import 'package:accident/Presentation/Emergency/Pages/emergency_screen.dart';
import 'package:accident/Presentation/Emergency/Pages/events_page.dart';
import 'package:accident/Presentation/Emergency/Pages/hostel_fees.dart';
import 'package:accident/Presentation/Emergency/Pages/notifications_screen.dart';
import 'package:accident/Presentation/Emergency/Profile/profile_page.dart';
import 'package:accident/Presentation/dashboard/pages/home_page.dart';
import 'package:accident/Presentation/scanner/pages/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Padding(
            //   padding:
            //       EdgeInsets.all(MediaQuery.of(context).size.height * 0.030),
            //   child: Text(
            //     'Hostel Dashboard',
            //     style: TextStyle(
            //         fontSize: MediaQuery.of(context).size.height * 0.026,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationsPage()));
                },
                child: const Icon(Icons.notifications_none_outlined)),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 15, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1323167284/photo/young-successful-indian-man-wearing-stylish-eyeglasses-standing-on-the-street-handsome-asian.jpg?s=612x612&w=0&k=20&c=gqsmYkDUEw5kQpuDvlFbkIGDy2-ISB6yK9zGe7rKlBI='),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rutik Jadhav',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Room: 101, Floor 1',
                    style: TextStyle(color: Colors.white),
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
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Events'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpcomingEventsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: _selectedIndex,
        onTap: _onItemTapped,
        circleColor:
            const Color.fromARGB(255, 221, 15, 0), // Active circle color
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

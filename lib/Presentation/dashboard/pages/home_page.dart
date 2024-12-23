// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/components/room_mates.dart';
import 'package:accident/Presentation/dashboard/components/upcoming_events.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _checkNetworkConnectivity();
  }

  Future<void> _checkNetworkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device is not connected to the network.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.110),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.110,
                  width: MediaQuery.of(context).size.height * 0.110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.110)),
                  child: Image.network(
                    'https://media.istockphoto.com/id/1323167284/photo/young-successful-indian-man-wearing-stylish-eyeglasses-standing-on-the-street-handsome-asian.jpg?s=612x612&w=0&k=20&c=gqsmYkDUEw5kQpuDvlFbkIGDy2-ISB6yK9zGe7rKlBI=',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),
              Text('Rutik Jadhav',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.022,
                      fontWeight: FontWeight.w600)),
              Text('Software Engineer',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.012,
                      fontWeight: FontWeight.w300)),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.0180,
                  right: MediaQuery.of(context).size.height * 0.0180,
                  top: MediaQuery.of(context).size.height * 0.0180,
                ),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.height * 0.0150),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.height * 0.0150)),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  MediaQuery.of(context).size.height * 0.0150),
                              topRight: Radius.circular(
                                  MediaQuery.of(context).size.height * 0.0150)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2600,
                            width: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height *
                                        0.110)),
                            child: Image.network(
                              'https://i.pinimg.com/550x/1a/25/24/1a2524f6efa620b2e167561b0ef30991.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.0180,
                            top: MediaQuery.of(context).size.height * 0.0180,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Room 101',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                        fontWeight: FontWeight.w600)),
                                Text('3 beds, AC, 📶 WIFI',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        fontWeight: FontWeight.w100)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.0180,
                  right: MediaQuery.of(context).size.height * 0.0180,
                ),
                child: Text(
                  'Room 101 is located on the first floor and includes facilities such as Wi-Fi, air conditioning, and a study desk. The room is spacious and well-ventilated, providing a comfortable living environment for students.',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.w100),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.0180),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room-Mates',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022,
                            fontWeight: FontWeight.w600),
                      ),
                      const RoomMates(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.0180,
                    right: MediaQuery.of(context).size.height * 0.0180),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022,
                            fontWeight: FontWeight.w600),
                      ),
                      const UpcomingEvents(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.018,
              )
            ],
          ),
        )),
      ),
    );
  }
}

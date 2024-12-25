// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:accident/data/api_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:accident/Presentation/Emergency/Models/profile_model.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/dashboard/Models/room_details.model.dart';
import 'package:accident/Presentation/dashboard/Models/room_mates_model.dart';
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/room_details_provider.dart';
import 'package:accident/Presentation/dashboard/components/room_mates.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StudentProfile? studentProfile;
  RoommateProfile? roommateProfile;
  RoomDetails? roomDetails;

  @override
  void initState() {
    super.initState();
    _checkNetworkConnectivity();
    _fetchStudentProfile().then((_) {
      _fetchRoomDetails(studentProfile?.roomNumber ?? 0);
    });
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

  Future<void> _fetchRoomDetails(int roomNumber) async {
    final provider = Provider.of<RoomDetailsProvider>(context, listen: false);
    final roomInfo = await provider.fetchRoomDetails(roomNumber);
    setState(() {
      roomDetails = roomInfo;
    });
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
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.0160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStudentProfileSection(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0160),
                _buildRoomDetailsSection(),
                _buildRoomMatesSection(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0160),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentProfileSection() {
    return studentProfile == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Column(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.055,
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.022,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.012,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          )
        : Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.110),
                child: Image.network(
                  '$baseUrl/student_regi/${studentProfile?.profilePic}',
                  height: MediaQuery.of(context).size.height * 0.110,
                  width: MediaQuery.of(context).size.height * 0.110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${studentProfile?.firstName ?? ''} ${studentProfile?.lastName ?? ''}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.022,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                studentProfile?.prefferedCourse ?? 'N/A',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.012,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ],
          );
  }

  Widget _buildRoomDetailsSection() {
    return roomDetails == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.350,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.0160),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.0160),
                  child: Image.network(
                    '$baseUrl/student_regi/${roomDetails?.image}',
                    height: MediaQuery.of(context).size.height * 0.260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.0160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room ${roomDetails?.roomNumber}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${roomDetails?.seater} beds',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.012,
                          fontWeight: FontWeight.w100,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        roomDetails?.description ?? '',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          fontWeight: FontWeight.w100,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildRoomMatesSection() {
    return roomDetails == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.022,
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.012,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Room-Mates',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.022,
                      fontWeight: FontWeight.w600)),
              const RoomMates(),
            ],
          );
  }
}

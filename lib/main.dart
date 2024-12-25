// main.dart
// ignore_for_file: avoid_print
import 'package:accident/Presentation/Emergency/Provider/student_installments.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/room_details_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/room_mates_provider.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/Presentation/scanner/Provider/scanner_provider.dart';
import 'package:accident/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyAppProviders());
}

class MyAppProviders extends StatelessWidget {
  const MyAppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<UserCredentials>(
          create: (_) => UserCredentials(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
            create: (_) => NavigationProvider()),
        ChangeNotifierProvider<StudentProfileProvider>(
            create: (_) => StudentProfileProvider()),
        ChangeNotifierProvider<RoomMatesProvider>(
            create: (_) => RoomMatesProvider()),
        ChangeNotifierProvider<RoomDetailsProvider>(
            create: (_) => RoomDetailsProvider()),
        ChangeNotifierProvider<StudentInstallmentsProvider>(
            create: (_) => StudentInstallmentsProvider()),
        ChangeNotifierProvider<ScannerProvider>(
            create: (_) => ScannerProvider()),
      ],
      child: MaterialApp(
        title: 'Your App Title',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const MyApp(),
      ),
    );
  }
}

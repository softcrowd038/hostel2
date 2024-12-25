// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

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
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the app after ensuring everything is set up
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
            create: (_) => UserCredentials()),
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
        home: const PermissionHandlerWrapper(),
      ),
    );
  }
}

class PermissionHandlerWrapper extends StatefulWidget {
  const PermissionHandlerWrapper({Key? key}) : super(key: key);

  @override
  _PermissionHandlerWrapperState createState() =>
      _PermissionHandlerWrapperState();
}

class _PermissionHandlerWrapperState extends State<PermissionHandlerWrapper> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      await requestPermissions();
      await checkPermissions();

      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      locationProvider.requestLocationPermissionAndGetCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

Future<void> requestPermissions() async {
  var status = await Permission.camera.status;
  if (status.isDenied || status.isPermanentlyDenied) {
    await Permission.camera.request();
  }
}

Future<void> checkPermissions() async {
  var status = await Permission.camera.status;
  if (status.isGranted) {
    debugPrint("Camera permission granted");
  } else {
    debugPrint("Camera permission not granted");
  }
}

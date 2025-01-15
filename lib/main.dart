// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:accident/Presentation/Emergency/Provider/accelerometer_provider.dart';
import 'package:accident/Presentation/Emergency/Provider/altitude_provider.dart';
import 'package:accident/Presentation/Emergency/Provider/gyroscope_provider.dart';
import 'package:accident/Presentation/Emergency/Provider/speed_provider.dart';
import 'package:accident/Presentation/Emergency/Provider/student_installments.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/Emergency/services/accident_detection_provider.dart';
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
import 'package:workmanager/workmanager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final locationProvider = LocationProvider();
    final speedProvider = SpeedTrackerNotifier();
    final altitudeProvider = AltitudeTracker();

    final context = navigatorKey.currentContext;

    if (context == null) {
      print('Context is not available.');
      return Future.value(false);
    }

    final accidentDetectionProvider = AccidentDetectionProvider(
        locationProvider: locationProvider,
        speedProvider: speedProvider,
        altitudeProvider: altitudeProvider,
        context: context);

    accidentDetectionProvider.checkForAccident();
    accidentDetectionProvider.checkAndSendSMS();

    print("Task is working in background");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  Workmanager().registerPeriodicTask(
    "uniqueName",
    "checkAndSendSMSTask",
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
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
        ChangeNotifierProvider<SpeedTrackerNotifier>(
            create: (_) => SpeedTrackerNotifier()),
        ChangeNotifierProvider<AltitudeTracker>(
            create: (_) => AltitudeTracker()),
        ChangeNotifierProvider<GyroscopeProvider>(
            create: (_) => GyroscopeProvider()),
        ChangeNotifierProvider<AccelerometerProvider>(
            create: (_) => AccelerometerProvider()),
        ChangeNotifierProvider<AccidentDetectionProvider>(
          create: (context) => AccidentDetectionProvider(
            locationProvider:
                Provider.of<LocationProvider>(context, listen: false),
            speedProvider:
                Provider.of<SpeedTrackerNotifier>(context, listen: false),
            altitudeProvider:
                Provider.of<AltitudeTracker>(context, listen: false),
            context: context,
          ),
        ),
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

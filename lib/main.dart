// main.dart
// ignore_for_file: avoid_print

import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
import 'package:accident/Presentation/Profile/Model/health_details_page.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/dashboard/Utils/accelerometer_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/altitude_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/gyroscope_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/navigation_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/speed_provider.dart';
import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/app/my_app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // Initialize necessary services and providers

    // This context is required to use providers.
    final context = inputData?['context'];

    if (context == null) {
      print('Context is not available.');
      return Future.value(false);
    }

    // Create the necessary providers
    final locationProvider = LocationProvider();
    final speedProvider = SpeedTrackerNotifier();
    final altitudeProvider = AltitudeTracker();

    final accidentDetectionProvider = AccidentDetectionProvider(
      locationProvider: locationProvider,
      speedProvider: speedProvider,
      altitudeProvider: altitudeProvider,
    );

    accidentDetectionProvider.checkForAccident();
    print("task is working in background");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA9R9GzGQrM5tpo20TUFTpdjjvH7_CaT3U",
      appId: "1:1019378541718:android:cbb6c9654e2fc6c7b30eb7",
      messagingSenderId: "1019378541718",
      projectId: "accident-df789",
    ),
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "accident_channel",
        channelName: "Detection Notification",
        channelDescription: "Notification Channel for basic test",
      ),
    ],
    debug: true,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  Workmanager().initialize(callbackDispatcher);

  runApp(const MyAppProviders());
}

class MyAppProviders extends StatelessWidget {
  const MyAppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Workmanager().registerPeriodicTask(
      "1", // This is a unique task identifier
      "simplePeriodicTask",
      frequency: const Duration(seconds: 5), // How often to run the task
      inputData: {'context': context}, // Pass context if needed
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfilePageModel>(
          create: (_) => ProfilePageModel(),
        ),
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<UserCredentials>(
          create: (_) => UserCredentials(),
        ),
        ChangeNotifierProvider<HealthDetailsModel>(
            create: (_) => HealthDetailsModel()),
        ChangeNotifierProvider<SpeedTrackerNotifier>(
            create: (_) => SpeedTrackerNotifier()),
        ChangeNotifierProvider<AltitudeTracker>(
            create: (_) => AltitudeTracker()),
        ChangeNotifierProvider<NavigationProvider>(
            create: (_) => NavigationProvider()),
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
          ),
        ),
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

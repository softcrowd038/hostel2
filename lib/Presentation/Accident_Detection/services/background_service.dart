// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:accident/Presentation/Accident_Detection/Pages/show_accident_notification.dart';
// import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
// import 'package:accident/Presentation/dashboard/Utils/altitude_provider.dart';
// import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
// import 'package:accident/Presentation/dashboard/Utils/speed_provider.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();

//   if (Platform.isAndroid) {
//     final locationProvider = LocationProvider();
//     final speedProvider = SpeedTrackerNotifier();
//     final altitudeProvider = AltitudeTracker();

//     if (!(await Permission.notification.isGranted)) {
//       var status = await Permission.notification.request();
//       if (!status.isGranted) {
//         print(
//             'Notification permission not granted. Cannot start foreground service.');
//         return;
//       }
//     }

//     await showAccidentNotification(AccidentDetectionProvider(
//       locationProvider: locationProvider,
//       speedProvider: speedProvider,
//       altitudeProvider: altitudeProvider,
//     ));

//     await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         autoStart: true,
//         isForegroundMode: true,
//         notificationChannelId: 'my_foreground',
//         initialNotificationTitle: 'Accident Detection Service',
//         initialNotificationContent: 'Monitoring your safety',
//       ),
//       iosConfiguration: IosConfiguration(
//         onForeground: onStart,
//         autoStart: true,
//       ),
//     );

//     service.startService();
//   }
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();

//   await Firebase.initializeApp();

//   if (service is AndroidServiceInstance) {
//     service.setForegroundNotificationInfo(
//       title: "Accident Detection Service",
//       content: "Monitoring your safety",
//     );

//     service.on('setAsForeground').listen((event) {
//       service.setForegroundNotificationInfo(
//         title: "Accident Detection Service",
//         content: "Monitoring your safety",
//       );
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setForegroundNotificationInfo(
//         title: "Accident Detection Service",
//         content: "Running in background",
//       );
//     });

//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//   }

//   final locationProvider = LocationProvider();
//   final speedProvider = SpeedTrackerNotifier();
//   final altitudeProvider = AltitudeTracker();

//   Timer.periodic(const Duration(seconds: 15), (timer) {
//     print('Background execution');

//     final accidentDetection = AccidentDetectionProvider(
//       locationProvider: locationProvider,
//       speedProvider: speedProvider,
//       altitudeProvider: altitudeProvider,
//     );
//     accidentDetection.checkForAccident();
//   });

//   service.invoke('update', {
//     "current_date": DateTime.now().toIso8601String(),
//   });
// }

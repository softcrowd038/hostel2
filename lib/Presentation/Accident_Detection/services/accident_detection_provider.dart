// ignore_for_file: avoid_print

import 'dart:async';
import 'package:accident/Presentation/Accident_Detection/Pages/show_accident_notification.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/dashboard/Utils/altitude_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/speed_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensors/sensors.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccidentDetectionProvider extends ChangeNotifier {
  static const double _accelerometerThreshold = 45.0;
  static const double speedThreshold = 70.0;
  static const double altitudeThreshold = 1000.0;
  static const double _threshold = 40.0;
  static const Duration _resetDuration = Duration(seconds: 30);

  bool _isAccidentDetected = false;
  bool hasStoredAccidentData = false;
  List<double> _accelerometerValues = [0.0, 0.0, 0.0];
  double speed = 0.0;
  double altitude = 0.0;
  List<double> gyroscopeValues = [0.0, 0.0, 0.0];
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  Timer? _resetTimer;
  DateTime? _lastSmsTimestamp;

  bool get isAccidentDetected => _isAccidentDetected;
  List<double> get accelerometerValues => _accelerometerValues;
  bool _notificationCancelled = false;
  ProfilePageModel? _userData;
  LocationProvider? _locationProvider;
  SpeedTrackerNotifier? _speedProvider;
  AltitudeTracker? _altitudeProvider;
  NotificationService notificationService = NotificationService();

  AccidentDetectionProvider({
    required LocationProvider locationProvider,
    required SpeedTrackerNotifier speedProvider,
    required AltitudeTracker altitudeProvider,
  }) {
    _locationProvider = locationProvider;
    _speedProvider = speedProvider;
    _altitudeProvider = altitudeProvider;
    _fetchUserData();
    _startMonitoringAccelerometer();
    _startMonitoringGyroscope();
    requestPermissions();

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("Action received: ${receivedAction.buttonKeyPressed}");
  }

  Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("Dismiss action received: ${receivedAction.buttonKeyPressed}");
    _notificationCancelled = true;
    print(
        "_notificationCancelled set to true in onDismissActionReceivedMethod");
  }

  Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("Notification created");
  }

  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("Notification displayed");
  }

  Future<void> _fetchUserData() async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      ProfilePageModel? userData =
          await FireStoreProfileData().getUserData(email);
      if (userData != null) {
        _userData = userData;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void requestPermissions() async {
    try {
      final bool? result = await Telephony.instance.requestSmsPermissions;
      if (result != null && result) {
        print("SMS permission granted");
      } else {
        print("SMS permission denied");
      }
    } catch (e) {
      print('Error requesting permissions: $e');
    }
  }

  void _startMonitoringAccelerometer() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      _accelerometerValues = [event.x, event.y, event.z];
      checkForAccident();
      notifyListeners();
    });
  }

  void _startMonitoringGyroscope() {
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      gyroscopeValues = [event.x, event.y, event.z];
      checkForAccident();
      notifyListeners();
    });
  }

  void triggerNotification() {
    notificationService.createInitialNotification();
  }

  void checkForAccident() {
    double gyroscopeMagnitude = gyroscopeValues[0].abs() +
        gyroscopeValues[1].abs() +
        gyroscopeValues[2].abs();

    double accelerometerMagnitude = accelerometerValues[0].abs() +
        accelerometerValues[1].abs() +
        accelerometerValues[2].abs();

    speed = _speedProvider?.speed ?? 0.0;
    altitude = _altitudeProvider?.altitude ?? 0.0;

    if (accelerometerMagnitude > _accelerometerThreshold ||
        speed > speedThreshold ||
        altitude > altitudeThreshold ||
        gyroscopeMagnitude > _threshold) {
      _isAccidentDetected = true;

      if (_isAccidentDetected) {
        triggerNotification();
        _startResetTimer();
      }

      notifyListeners();
    }
  }

  void _startResetTimer() {
    _resetTimer?.cancel();
    _resetTimer = Timer(_resetDuration, () async {
      print("Timer finished");
      print("_notificationCancelled: $_notificationCancelled");
      if (!_notificationCancelled) {
        print("entered if");
        sendEmergencySMS();
        await storeAccidentData();
        AwesomeNotifications().cancel(10);
      } else {
        print("entered else");
        _notificationCancelled = false;
      }
      _isAccidentDetected = false;
      hasStoredAccidentData = false;
      notifyListeners();
    });
  }

  void sendEmergencySMS() async {
    if (_lastSmsTimestamp == null ||
        DateTime.now().difference(_lastSmsTimestamp!) >
            const Duration(seconds: 30)) {
      try {
        if (_userData == null || _userData!.emergencyPhone == null) {
          print('Emergency phone number is not available.');
          return;
        }

        String emergencyNumber = _userData!.emergencyPhone!;
        LatLng? currentPosition = _locationProvider?.currentPosition;
        if (currentPosition == null) {
          print('Current position is not available.');
          return;
        }
        String message = 'https://www.google.com/maps/search/?api=1'
            '&query=${currentPosition.latitude},${currentPosition.longitude}';
        Telephony.backgroundInstance.sendSms(
            to: emergencyNumber,
            message: 'Hey, I caught in accident, at this location: $message');

        print('Emergency SMS sent successfully to $emergencyNumber');
        _lastSmsTimestamp = DateTime.now();
      } catch (e) {
        print('Error sending emergency SMS: $e');
      }
    } else {
      print('SMS not sent due to cooldown period');
    }
  }

  Future<void> storeAccidentData() async {
    if (hasStoredAccidentData) {
      return;
    }
    hasStoredAccidentData = true;

    try {
      DateTime currentTime = DateTime.now();
      String? currentAddress = _locationProvider?.currentAddress;
      String location = currentAddress ?? "Unknown location";
      LatLng? currentPosition = _locationProvider?.currentPosition;

      String date =
          "${currentTime.year}-${currentTime.month}-${currentTime.day}";
      String time = "${currentTime.hour}:${currentTime.minute}";

      await FirebaseFirestore.instance.collection('accidents').add({
        'date': date,
        'time': time,
        'location': location,
        'speed': speed.toStringAsFixed(2),
        'altitude': altitude.toStringAsFixed(2),
        'latitude': currentPosition?.latitude,
        'longitude': currentPosition?.longitude,
      });
      print('Accident data stored successfully!');
    } catch (e) {
      print('Error storing accident data: $e');
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    _resetTimer?.cancel();
    _startResetTimer();
    requestPermissions();
    super.dispose();
  }
}

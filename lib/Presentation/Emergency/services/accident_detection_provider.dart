// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';
import 'package:accident/Presentation/Emergency/Models/profile_model.dart';
import 'package:accident/Presentation/Emergency/Provider/altitude_provider.dart';
import 'package:accident/Presentation/Emergency/Provider/speed_provider.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

class AccidentDetectionProvider extends ChangeNotifier {
  static const double _accelerometerThreshold = 30.0;
  static const double speedThreshold = 40.0;
  static const double altitudeThreshold = 1000.0;
  static const double _threshold = 20.0;
  static const Duration _resetDuration = Duration(seconds: 5);
  static const Duration _cooldownDuration = Duration(seconds: 15);

  bool _isAccidentDetected = false;
  bool hasStoredAccidentData = false;
  List<double> _accelerometerValues = [0.0, 0.0, 0.0];
  double speed = 0.0;
  double altitude = 0.0;
  List<double> gyroscopeValues = [0.0, 0.0, 0.0];
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  Timer? _resetTimer;
  Timer? _cooldownTimer;
  DateTime? _lastSmsTimestamp;

  bool get isAccidentDetected => _isAccidentDetected;
  List<double> get accelerometerValues => _accelerometerValues;
  bool _notificationCancelled = false;
  LocationProvider? _locationProvider;
  SpeedTrackerNotifier? _speedProvider;
  AltitudeTracker? _altitudeProvider;
  BuildContext context;

  AccidentDetectionProvider({
    required LocationProvider locationProvider,
    required SpeedTrackerNotifier speedProvider,
    required AltitudeTracker altitudeProvider,
    required this.context,
  }) {
    _locationProvider = locationProvider;
    _speedProvider = speedProvider;
    _altitudeProvider = altitudeProvider;
    _startMonitoringAccelerometer();
    _startMonitoringGyroscope();
    Timer(const Duration(seconds: 5), () {
      requestPermissions();
    });
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

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void checkForAccident() {
    double gyroscopeMagnitude = gyroscopeValues[0].abs() +
        gyroscopeValues[1].abs() +
        gyroscopeValues[2].abs();

    double accelerometerMagnitude = accelerometerValues[0].abs() +
        accelerometerValues[1].abs() +
        accelerometerValues[2].abs();

    double suddenDeceleration = accelerometerValues[0] +
        accelerometerValues[1] +
        accelerometerValues[2];
    double angularVelocity =
        gyroscopeValues[0] + gyroscopeValues[1] + gyroscopeValues[2];

    speed = _speedProvider?.speed ?? 0.0;
    altitude = _altitudeProvider?.altitude ?? 0.0;

    // Enhanced logic: Check for combined thresholds
    bool isSuddenStop =
        speed < 10 && suddenDeceleration > _accelerometerThreshold;
    bool isAngularDisplacementAbnormal = angularVelocity.abs() > _threshold;
    bool isGyroscopeHigh = gyroscopeMagnitude > (_threshold * 1.5);
    bool isHighImpact = accelerometerMagnitude > _accelerometerThreshold;

    if (isSuddenStop ||
        isAngularDisplacementAbnormal ||
        isHighImpact ||
        isGyroscopeHigh) {
      _isAccidentDetected = true;

      if (_isAccidentDetected) {
        _startResetTimer();
      }

      notifyListeners();
    }
  }

  void checkAndSendSMS() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final checkInStatus = sharedPreferences.getString('status');
    final now = DateTime.now();

    bool isAfter8PM = now.hour > 8 || (now.hour == 8 && now.minute >= 0);

    if (checkInStatus != 'checked-in' && isAfter8PM) {
      print('Time exceeds 8:00 PM and student is not checked in.');
      sendNotInHostelSMS(context);
    }
  }

  void _startResetTimer() {
    _resetTimer?.cancel();
    _resetTimer = Timer(_resetDuration, () async {
      print("Timer finished");
      print("_notificationCancelled: $_notificationCancelled");
      if (!_notificationCancelled) {
        print("entered if");
        sendEmergencySMS(context);
      } else {
        print("entered else");
        _notificationCancelled = false;
      }
      _isAccidentDetected = false;
      hasStoredAccidentData = false;
      notifyListeners();
    });
  }

  void sendEmergencySMS(BuildContext context) async {
    if (_lastSmsTimestamp == null ||
        DateTime.now().difference(_lastSmsTimestamp!) > _cooldownDuration) {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final uuid = sharedPreferences.getString('user_uuid');
        final storeProfileData =
            Provider.of<StudentProfileProvider>(context, listen: false);
        StudentProfile? userData =
            await storeProfileData.fetchStudentProfile(uuid!);

        if (userData!.emergencyContactNumber == null) {
          print('Emergency phone number is not available.');
          return;
        }

        String emergencyNumber = userData.emergencyContactNumber;
        LatLng? currentPosition = _locationProvider?.currentPosition;
        if (currentPosition == null) {
          print('Current position is not available.');
          return;
        }

        String message =
            'https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}';

        Telephony.backgroundInstance.sendSms(
            to: emergencyNumber,
            message:
                '${userData.firstName} is caught in an emergency at this location: $message , contact her immediately');

        print('Emergency SMS sent successfully to $emergencyNumber');
        _lastSmsTimestamp = DateTime.now();
      } catch (e) {
        print('Error sending emergency SMS: $e');
      }
    } else {
      print('SMS not sent due to cooldown period');
    }
  }

  void sendNotInHostelSMS(BuildContext context) async {
    if (_lastSmsTimestamp == null ||
        DateTime.now().difference(_lastSmsTimestamp!) > _cooldownDuration) {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final uuid = sharedPreferences.getString('user_uuid');
        final storeProfileData =
            Provider.of<StudentProfileProvider>(context, listen: false);
        StudentProfile? userData =
            await storeProfileData.fetchStudentProfile(uuid!);

        if (userData!.emergencyContactNumber == null) {
          print('Emergency phone number is not available.');
          return;
        }

        String emergencyNumber = userData.emergencyContactNumber;
        LatLng? currentPosition = _locationProvider?.currentPosition;
        if (currentPosition == null) {
          print('Current position is not available.');
          return;
        }

        String message =
            'https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}';

        Telephony.backgroundInstance.sendSms(
            to: emergencyNumber,
            message:
                '${userData.firstName} is still outside hostel!, Hostel is closed now and she is at this location: $message');

        print('Emergency SMS sent successfully to $emergencyNumber');
        _lastSmsTimestamp = DateTime.now();
      } catch (e) {
        print('Error sending emergency SMS: $e');
      }
    } else {
      print('SMS not sent due to cooldown period');
    }
  }

  void startCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer(_cooldownDuration, () {
      print("Cooldown period finished");
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    _resetTimer?.cancel();
    _cooldownTimer?.cancel();
    requestPermissions();
    super.dispose();
  }
}

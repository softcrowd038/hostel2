// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:accident/Presentation/dashboard/Utils/location_provider.dart';
import 'package:accident/Presentation/scanner/Provider/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';
import 'package:accident/Presentation/Emergency/Models/profile_model.dart';

class SMSService {
  DateTime? _lastSmsTimestamp;

  void sendCheckInCheckOutSMS(
      StudentProfile? studentProfile, BuildContext context) async {
    if (!context.mounted) return;
    final provider = Provider.of<ScannerProvider>(context, listen: false);

    if (_lastSmsTimestamp == null ||
        DateTime.now().difference(_lastSmsTimestamp!) >
            const Duration(seconds: 5)) {
      try {
        if (studentProfile?.guardianContact == null) {
          print('Emergency phone number is not available.');
          return;
        }

        String emergencyNumber = studentProfile!.guardianContact;

        String message = studentProfile.firstName;
        await Telephony.instance.sendSms(
            to: emergencyNumber,
            message:
                '$message is just ${provider.checkInStatus}  ${provider.checkInStatus == 'checked-in' ? 'in' : 'from'} hostel');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Emergency SMS sent to your ${studentProfile.relation}')),
        );
        _lastSmsTimestamp = DateTime.now();
      } catch (e) {
        print('Error sending emergency SMS: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS not sent due to cooldown period')),
      );
    }
  }

  void sendEmergencySMS(
      StudentProfile? studentProfile, BuildContext context) async {
    final provider = Provider.of<LocationProvider>(context, listen: false);

    if (_lastSmsTimestamp == null ||
        DateTime.now().difference(_lastSmsTimestamp!) >
            const Duration(seconds: 15)) {
      try {
        if (studentProfile?.emergencyContactNumber == null) {
          print('Emergency phone number is not available.');
          return;
        }

        String emergencyNumber = studentProfile!.emergencyContactNumber;
        LatLng? currentPosition = provider.currentPosition;
        print(currentPosition?.latitude);
        if (currentPosition == null) {
          print('Current position is not available.');
          return;
        }

        String message = 'https://www.google.com/maps/search/?api=1'
            '&query=${currentPosition.latitude},${currentPosition.longitude}';
        await Telephony.instance.sendSms(
            to: emergencyNumber,
            message:
                '${studentProfile.firstName} is caught in an emergency at this location: $message , contact her immediately');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Emergency SMS sent to $emergencyNumber')),
        );
        _lastSmsTimestamp = DateTime.now();
      } catch (e) {
        print('Error sending emergency SMS: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS not sent due to cooldown period')),
      );
    }
  }
}

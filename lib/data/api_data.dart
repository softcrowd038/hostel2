// ignore_for_file: avoid_print

import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

const String baseUrl = 'https://hostel-management.co.codiantsolutions.com/api';

final regexemail = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
final regexpassword =
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

void requestPermissions() async {
  try {
    final bool? result = await Telephony.instance.requestSmsPermissions;
    if (result == true) {
      print("SMS permission granted");
    } else {
      print("SMS permission denied");
    }
  } catch (e) {
    print('Error requesting permissions: $e');
  }
}

Future<void> checkPermissions() async {
  var status = await Permission.camera.status;
  if (status.isDenied) {
    await Permission.camera.request();
  }
}

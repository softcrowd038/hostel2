// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ScannerPage extends StatefulWidget {
  const ScannerPage({
    super.key,
  });

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String qrResult = "";
  bool isClicked = false;
  double turns = 0.0;
  bool isCheckedIn = false;
  String uniqueID = "Rutik@123";
  MobileScannerController? scannerController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initial();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<SharedPreferences> getSharedPreferencesInstance() async {
    return await SharedPreferences.getInstance();
  }

  String? visitorId;

  void initial() async {
    SharedPreferences prefs = await getSharedPreferencesInstance();
    visitorId = prefs.getString("visitorId");
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processScanResult(String qrCode) async {
    String apiUrl =
        'https://softcrowd.in/gaushala_management_system/login_api/check_in_out_api.php';

    try {
      Map<String, dynamic> requestData = {
        'qrCode': qrCode,
        'action': isCheckedIn ? 'check_out' : 'check_in',
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String time = data['time'] ?? '';

        if (isCheckedIn) {
          _saveCheckOutTimeLocally(time);
        } else {
          _saveCheckInTimeLocally(time);
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSuccessDialog(
              '${isCheckedIn ? 'Check-out' : 'Check-in'} successful!');
        });
      } else {
        _showErrorDialog('Failed to ${isCheckedIn ? 'check_out' : 'check_in'}');
      }

      setState(() => isCheckedIn = !isCheckedIn);
    } catch (e) {
      _showErrorDialog(
          'Error during ${isCheckedIn ? 'check_out' : 'check_in'}');
    }
  }

  void _saveCheckInTimeLocally(String checkInTime) {
    print('Check-in time saved locally: $checkInTime');
  }

  void _saveCheckOutTimeLocally(String checkOutTime) {
    print('Check-out time saved locally: $checkOutTime');
  }

  void _showSuccessDialog(String successMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(successMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void startScanner() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black),
            ),
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                returnImage: true,
              ),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;

                for (final barcode in barcodes) {
                  String qrCode = barcode.rawValue ?? "";
                  if (qrCode.isNotEmpty && qrCode == uniqueID) {
                    _processScanResult(qrCode);
                    Navigator.pop(context);
                    break;
                  } else {
                    _showErrorDialog("Invalid QR Code!");
                  }
                }

                if (image != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(barcodes.first.rawValue ?? ""),
                      content: Image.memory(image),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                      'https://img.freepik.com/free-vector/qr-code-scanning-concept-with-characters-illustrated_23-2148633631.jpg?t=st=1731662909~exp=1731666509~hmac=ec5aca77af0fbc48e3907594fa49b775f91d4778f942db38cf045ada43c8b9bf&w=740'),
                ),
                Text(
                  'SCAN QR',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.024,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Click below Button to Scan QR CODE to ${isCheckedIn ? 'Checkout' : 'CheckIn'}',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 161, 161, 161),
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                    startScanner();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.0150),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      width: MediaQuery.of(context).size.width,
                      color: isCheckedIn
                          ? const Color.fromARGB(255, 221, 15, 0)
                          : const Color.fromARGB(255, 10, 82, 12),
                      child: Center(
                        child: Text(
                          isCheckedIn ? 'Check Out' : 'Check In',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

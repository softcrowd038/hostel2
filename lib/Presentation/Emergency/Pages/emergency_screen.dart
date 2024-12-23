import 'package:flutter/material.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EmergencyScreen();
}

class _EmergencyScreen extends State<EmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(
                  'https://img.freepik.com/free-vector/emergency-call-concept-illustration_114360-6864.jpg'),
            ),
            Text(
              'Emergency',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.024,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.018),
              child: Text(
                'Press the below button in case of emergency it will share you live location to your parents',
                style: TextStyle(
                    color: const Color.fromARGB(255, 161, 161, 161),
                    fontSize: MediaQuery.of(context).size.height * 0.015),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.0150),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.050,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 221, 15, 0),
                  child: Center(
                    child: Text(
                      'Press',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.018),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

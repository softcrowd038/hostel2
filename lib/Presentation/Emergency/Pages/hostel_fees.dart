import 'package:flutter/material.dart';

class HostelFees extends StatefulWidget {
  const HostelFees({super.key});

  @override
  State<StatefulWidget> createState() => _HostelFees();
}

class _HostelFees extends State<HostelFees> {
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
                  'https://img.freepik.com/free-vector/tiny-students-sitting-near-books-getting-university-degree-paying-money-education-business-flat-vector-illustration-college-scholarship-finance-system-school-fee-economy-student-loan-concept_74855-21037.jpg'),
            ),
            Text(
              'Hostel Fees',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.024,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.018),
              child: Text(
                'See your Hostel Fees status here',
                style: TextStyle(
                    color: const Color.fromARGB(255, 161, 161, 161),
                    fontSize: MediaQuery.of(context).size.height * 0.015),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.0180),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.100,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Fees',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.024,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '20000 /-',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 161, 161, 161),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remaining Fees',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.024,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '25000 /-',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 161, 161, 161),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

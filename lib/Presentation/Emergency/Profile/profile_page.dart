// ignore_for_file: use_build_context_synchronously

import 'package:accident/Presentation/Emergency/Models/profile_model.dart';
import 'package:accident/Presentation/Emergency/Models/student_installments.dart';
import 'package:accident/Presentation/Emergency/Provider/student_installments.dart';
import 'package:accident/Presentation/Emergency/Provider/student_profile_provider.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/personal_info_row.dart';
import 'package:accident/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  StudentProfile? studentProfile;
  StudentInstallments? studentInstallments;

  @override
  void initState() {
    super.initState();
    _fetchStudentProfile().then((_) {
      _fetchStudentInstallments(studentProfile?.registrationNumber ?? '');
    });
  }

  Future<void> _fetchStudentProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final uuid = sharedPreferences.getString('user_uuid');
    final provider =
        Provider.of<StudentProfileProvider>(context, listen: false);
    final profile = await provider.fetchStudentProfile(uuid!);
    setState(() {
      studentProfile = profile;
    });
  }

  Future<void> _fetchStudentInstallments(String regiNum) async {
    final provider =
        Provider.of<StudentInstallmentsProvider>(context, listen: false);
    final profile = await provider.fetchStudentInstallments(regiNum);
    setState(() {
      studentInstallments = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: studentProfile == null
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.120,
                            width: MediaQuery.of(context).size.height * 0.120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height *
                                        0.120)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.120),
                              child: Image.network(
                                '$baseUrl/student_regi/${studentProfile!.profilePic}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.008,
                          ),
                          Text(
                              '${studentProfile?.firstName ?? ''} ${studentProfile?.lastName ?? ''}',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.028,
                                  fontWeight: FontWeight.w600)),
                          Text(studentProfile?.prefferedCourse ?? '',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.018),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Personal Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.022),
                            ),
                          ),
                          PersonalInfoRow(
                              icon: Icons.smartphone,
                              title: 'Contact Number',
                              value: studentProfile?.contactNumber ?? 'N/A'),
                          PersonalInfoRow(
                              icon: Icons.email,
                              title: 'Email',
                              value: studentProfile?.email ?? 'N/A'),
                          PersonalInfoRow(
                              icon: Icons.male,
                              title: 'Gender',
                              value: studentProfile?.gender ?? 'N/A'),
                          PersonalInfoRow(
                              icon: Icons.contact_emergency,
                              title: 'Emergency Contact',
                              value: studentProfile?.emergencyContactNumber ??
                                  'N/A'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.018,
                          bottom: MediaQuery.of(context).size.height * 0.018),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Fees Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.022),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.0080,
                            right: MediaQuery.of(context).size.height * 0.0080,
                            bottom:
                                MediaQuery.of(context).size.height * 0.0180),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.008),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.008),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Paid Fees',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      studentInstallments?.duePayment ?? '0',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.008),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.008),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Installments',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        studentInstallments?.installment ?? '0',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.005),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.008),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Due Fees',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        studentInstallments?.remainingPayment ??
                                            '0',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.018),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gaurdian Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.022),
                            ),
                          ),
                          PersonalInfoRow(
                              icon: Icons.person,
                              title: 'Name',
                              value: studentProfile?.guardianName ?? 'N/A'),
                          PersonalInfoRow(
                              icon: Icons.handshake,
                              title: 'Relation',
                              value: studentProfile?.relation ?? 'N/A'),
                          PersonalInfoRow(
                              icon: Icons.call,
                              title: 'Contact',
                              value: studentProfile?.guardianContact ?? 'N/A'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.018),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Address Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.022),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.018),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(1, 1),
                                                  color: Colors.black
                                                      .withOpacity(0.2))
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.008),
                                          child: const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.red,
                                          ),
                                        )),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                    ),
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height *
                                      0.045,
                                ),
                                Expanded(
                                  child: Text(studentProfile?.address ?? ''),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

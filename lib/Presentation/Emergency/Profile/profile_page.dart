import 'package:accident/Presentation/dashboard/components/seconadary_components/personal_info_row.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                              MediaQuery.of(context).size.height * 0.120)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.120),
                        child: Image.network(
                          'https://media.istockphoto.com/id/1323167284/photo/young-successful-indian-man-wearing-stylish-eyeglasses-standing-on-the-street-handsome-asian.jpg?s=612x612&w=0&k=20&c=gqsmYkDUEw5kQpuDvlFbkIGDy2-ISB6yK9zGe7rKlBI=',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Text('Rutik Jadhav',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.028,
                            fontWeight: FontWeight.w600)),
                    Text('Software Engineer',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.012,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.018),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Personal Information',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022),
                      ),
                    ),
                    PersonalInfoRow(
                        icon: Icons.smartphone,
                        title: 'Contact Number',
                        value: '8080762003'),
                    PersonalInfoRow(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'rutik@gmail.com'),
                    PersonalInfoRow(
                        icon: Icons.male, title: 'Gender', value: 'male'),
                    PersonalInfoRow(
                        icon: Icons.contact_emergency,
                        title: 'Emergency Contact',
                        value: '8208522167'),
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
                        fontSize: MediaQuery.of(context).size.height * 0.022),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.0080,
                      right: MediaQuery.of(context).size.height * 0.0080,
                      bottom: MediaQuery.of(context).size.height * 0.0180),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Paid Fees',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '20000 /-',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
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
                                MediaQuery.of(context).size.height * 0.008),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.008),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Installments',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '2',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
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
                                MediaQuery.of(context).size.height * 0.005),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.008),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Due Fees',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '25000 /-',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
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
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.018),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Gaurdian Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022),
                      ),
                    ),
                    PersonalInfoRow(
                        icon: Icons.person,
                        title: 'Name',
                        value: 'Bharat Jadhav'),
                    PersonalInfoRow(
                        icon: Icons.handshake,
                        title: 'Relation',
                        value: 'Father'),
                    PersonalInfoRow(
                        icon: Icons.call,
                        title: 'Contact',
                        value: '8208522167'),
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
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022),
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
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.025),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(1, 1),
                                            color:
                                                Colors.black.withOpacity(0.2))
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height *
                                            0.008),
                                    child: const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.red,
                                    ),
                                  )),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
                              Text(
                                'Address',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.045,
                          ),
                          const Expanded(
                            child: Text(
                                'Hosue no.36 , Dhangar Galli Ozar mig, tal. Niphad,  Dist. Nashik, Maharashtra, 422207'),
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

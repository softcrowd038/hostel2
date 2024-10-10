import 'package:accident/Presentation/Navigation/page_navigation.dart';
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_calender.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirthDatePage extends StatefulWidget {
  const BirthDatePage({super.key});

  @override
  State<BirthDatePage> createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(image: AssetImage("assets/images/birthday.png")),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "SELECT YOUR BIRTHDAY 🎉 ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomCalendar(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1800),
                  lastDate: DateTime(2300)),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final profilePageProvider =
              Provider.of<ProfilePageModel>(context, listen: false);
          FireStoreProfileData().storeUserData(
            profilePageProvider.imageurl,
            profilePageProvider.name,
            profilePageProvider.email,
            profilePageProvider.phone,
            profilePageProvider.emergencyContactName,
            profilePageProvider.relation,
            profilePageProvider.emergencyPhone,
            profilePageProvider.address,
            profilePageProvider.birthdate,
            profilePageProvider.gender,
          );
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const HomePage())));
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}

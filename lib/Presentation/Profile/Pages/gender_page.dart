import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/birthday_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({
    Key? key,
  }) : super(key: key);

  @override
  GenderPageState createState() => GenderPageState();
}

class GenderPageState extends State<GenderPage> {
  ProfilePageModel? profilePageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<ProfilePageModel>(
            builder: (context, genderProvider, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "SELECT GENDER",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 5,
                              blurRadius: 9,
                              offset: const Offset(1, 1),
                              color: Colors.black.withOpacity(0.2),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.purple,
                                    backgroundImage:
                                        AssetImage("assets/images/man1.png"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 75.0, top: 12.0),
                                    child: RadioListTile<String>(
                                      value: 'Male',
                                      activeColor: Colors.purple,
                                      groupValue: genderProvider.gender,
                                      onChanged: (value) {
                                        genderProvider.setGender(value!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/woman1.png"),
                                      height: 110,
                                      width: 110,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 55.0),
                                    child: RadioListTile<String>(
                                      value: 'Female',
                                      activeColor: Colors.purple,
                                      groupValue: genderProvider.gender,
                                      onChanged: (value) {
                                        genderProvider.setGender(value!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const BirthDatePage())));
        },
        backgroundColor: Colors.purple.withOpacity(0.5),
        child: const Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}

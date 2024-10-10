// ignore_for_file: unused_element
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Pages/gender_page.dart';
import 'package:accident/Presentation/Profile/Widgets/custom_textfield.dart';
import 'package:accident/Presentation/Profile/Widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _guardianController = TextEditingController();
  TextEditingController _relationController = TextEditingController();
  TextEditingController _emergencyPhoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _guardianController = TextEditingController();
    _relationController = TextEditingController();
    _emergencyPhoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  void _updateName(String value) {
    Provider.of<ProfilePageModel>(context, listen: false).setName(value);
  }

  void _updateEmail(String value) {
    Provider.of<ProfilePageModel>(context, listen: false).setEmail(value);
  }

  void _updatePhone(String value) {
    Provider.of<ProfilePageModel>(context, listen: false).setPhone(value);
  }

  void _updateEmergencyContactName(String value) {
    Provider.of<ProfilePageModel>(context, listen: false)
        .setEmergencyContactName(value);
  }

  void _updateRelation(String value) {
    Provider.of<ProfilePageModel>(context, listen: false).setRelation(value);
  }

  void _updateEmergencyPhone(String value) {
    Provider.of<ProfilePageModel>(context, listen: false)
        .setEmergencyPhone(value);
  }

  void _updateAdress(String value) {
    Provider.of<ProfilePageModel>(context, listen: false).setAddress(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Stack(children: [
          Positioned(
              top: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.25,
              child: const ProfilePictureField(isEdit: false)),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.27,
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updateName(value);
                            },
                            obscureText: false,
                            hint: "eg. John Doe",
                            label: "Name",
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Name first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updateEmail(value);
                            },
                            obscureText: false,
                            hint: "xyz123@pqr.abc",
                            label: "Email",
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Email first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updateAdress(value);
                            },
                            obscureText: false,
                            hint:
                                "John Doe123, Main Street,Gandhi Nagar,Bangalore,Karnataka - 560001,India",
                            label: "Adress",
                            controller: _addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Emergency Phone first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.home,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updatePhone(value);
                            },
                            obscureText: false,
                            hint: "+91 1234567890",
                            label: "Phone",
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Phone first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updateEmergencyContactName(value);
                            },
                            obscureText: false,
                            hint: "eg. Alex Doe",
                            label: "Guardian",
                            controller: _guardianController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Name first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.person_2,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updateRelation(value);
                            },
                            obscureText: false,
                            hint: "eg. father",
                            label: "Relation",
                            controller: _relationController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Relation first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.group,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            onChanged: (value) {
                              _updateEmergencyPhone(value);
                            },
                            obscureText: false,
                            hint: "+91 1234567890",
                            label: "Emergency Phone",
                            controller: _emergencyPhoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Emergency Phone first!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            color: Colors.black,
                            suffixIcon: const Icon(
                              Icons.phone_android,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const GenderPage())));
          }
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}

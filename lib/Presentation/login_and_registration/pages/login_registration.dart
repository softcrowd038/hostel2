import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/Presentation/login_and_registration/Services/api_service.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/common_textform_field.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:accident/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  ApiService apiService = ApiService();

  Future<void> loginStudent(String email, String password) async {
    try {
      await apiService.loginStudent(context, email, password);
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  void _updateEmail(String value) {
    Provider.of<UserCredentials>(context, listen: false).setEmail(value);
  }

  void _updatePassword(String value) {
    Provider.of<UserCredentials>(context, listen: false).setPassword(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Consumer<UserCredentials>(
          builder: (context, userCredentials, child) => Form(
            key: _formKey,
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 0, 0)),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.92,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.250),
                                topRight: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.250),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.015),
                                  child: Text(
                                    "SIGNIN",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 216, 14, 0)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.015,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  child: Text(
                                    "Login And Unlock Your  Safety!",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.030,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  right: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                child: CommonTextFormfield(
                                  onChanged: (value) {
                                    _updateEmail(value);
                                  },
                                  label: "Email",
                                  hint: "xyz@abc.pqr",
                                  obscure: false,
                                  controller: _emailController,
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the Email first!";
                                    }
                                    if (!regexemail.hasMatch(value)) {
                                      return "Enter Valid Email Format!";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  right: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                child: CommonTextFormfield(
                                  onChanged: (value) {
                                    _updatePassword(value);
                                  },
                                  label: "Password",
                                  hint: "MNop1234@#",
                                  obscure: true,
                                  controller: _passwordController,
                                  suffixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter the Password first!";
                                    }
                                    if (value.length < 8) {
                                      return "Password is too short, Enter up to 8 digits!";
                                    }
                                    if (!regexpassword.hasMatch(value)) {
                                      return "Use Alphabets(capital and small), symbols and numbers in the password";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginStudent(_emailController.text,
                                        _passwordController.text);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.015),
                                  child: const CustomButton(
                                    buttonText: "SignIn",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

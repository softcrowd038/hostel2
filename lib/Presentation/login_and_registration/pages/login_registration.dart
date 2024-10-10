import 'package:accident/Presentation/login_and_registration/Model/user_.dart';
import 'package:accident/Presentation/login_and_registration/Services/signup_signin.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/common_textform_field.dart';
import 'package:accident/Presentation/login_and_registration/Widgets/custom_button_.dart';
import 'package:accident/Presentation/login_and_registration/pages/forget_password.dart';
import 'package:accident/Presentation/login_and_registration/pages/registration_.dart';
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
  late TextEditingController _reEnterPasswordController =
      TextEditingController();
  final regexe = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
  final regexpa =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _reEnterPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 8.0),
                            child: Center(
                              child: Text(
                                "SIGNIN",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            )),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, bottom: 15.0, right: 15.0),
                            child: Center(
                              child: Text(
                                "Login And Unlock Your  Safety!",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            bottom: 10,
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
                              if (!regexe.hasMatch(value)) {
                                return "Enter Valid Email Format!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            bottom: 15,
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
                              if (!regexpa.hasMatch(value)) {
                                return "Use Alphabets(capital and small), symbols and numbers in the password";
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              ForgotPasswordScreen())));
                                },
                                child: const Text(
                                  " Forget password?",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 92, 92, 92)),
                                )),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              UiHelper(context).signIn(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: CustomButton(
                              buttonText: "SignIn",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 105, 105, 105),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationPage()));
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}

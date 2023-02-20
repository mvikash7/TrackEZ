import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_application/firebase_data/user_profile.dart';
import 'package:first_application/screens/home_screen.dart';
import 'package:first_application/utils/constants.dart';
import 'package:first_application/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import '../utils/shared_pref.dart';
import '../widget/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _fullNameTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _managerNameTextController;

  final _formKey = GlobalKey<FormState>();
  final validator = Validator();
  final pref = SharedPref();

  String userType = "employee";

  @override
  void initState() {
    super.initState();
    _fullNameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _managerNameTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, Constants.SIGN_UP_TEXT),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 15, right: 15, bottom: 20),
                child: TextFormField(
                  controller: _fullNameTextController,
                  decoration: reusableDecoration(
                      Constants.ENTER_FULLNAME_HINT, Icons.person_outline),
                  validator: validator.validateUserName,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _emailTextController,
                  decoration: reusableDecoration(
                      Constants.EMAIL_HINT, Icons.email_outlined),
                  validator: validator.validateEmail,

                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _passwordTextController,
                  decoration: reusableDecoration(
                      Constants.ENTER_PASSWORD_HINT, Icons.lock_outline),
                  validator: validator.validatePassword,
                  obscureText: true,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _confirmPasswordTextController,
                  decoration: reusableDecoration(
                      Constants.CONFORM_PASSWORD_HINT, Icons.lock),
                  validator: validator.validateConfirmPassword,
                  obscureText: true,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _managerNameTextController,
                  decoration: reusableDecoration(
                      Constants.MANAGER_NAME_HINT, Icons.manage_accounts_outlined),
                  validator: validator.validateUserName,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(Constants.USER_TYPE_TEXT, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),

              RadioListTile(
                title: const Text("Developer / Tester"),
                value: "employee",
                groupValue: userType,
                onChanged: (value) {
                  setState(() {
                    userType = value.toString();
                  });
                },
              ),

              RadioListTile(
                title: const Text("Manager"),
                value: "manager",
                groupValue: userType,
                onChanged: (value) {
                  setState(() {
                    userType = value.toString();
                  });
                },
              ),

              RadioListTile(
                  title: const Text("Admin"),
                  value: "admin",
                  groupValue: userType,
                  onChanged: (value) {
                    setState(() {
                      userType = value.toString();
                    });
                  }
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: signInSignUpButton(context, false, () async {
                  if (_formKey.currentState!.validate()) {
                    Loader.show(context, progressIndicator: const CircularProgressIndicator(backgroundColor: Colors.blue));
                    Future.delayed(const Duration(seconds: 1),() async {
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text).then((value) {
                          userSetup(_fullNameTextController.text,
                              _managerNameTextController.text,
                              userType,
                              _emailTextController.text);
                          pref.cacheUserProfileData(_emailTextController.text,
                              _managerNameTextController.text,
                              _fullNameTextController.text,
                              userType);
                          Navigator.pop(context, true);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()));
                          Loader.hide();
                        }
                        );
                      } on FirebaseAuthException catch (e) {
                        Loader.hide();
                        if (e.code == 'email-already-in-use') {
                          await showAlertDialog(context, 'Email currently in use');
                        } else if (e.code == 'weak-password') {
                          await showAlertDialog(context, 'Password is weak. Enter strong Password');
                          }
                        } catch (e) {
                        await showAlertDialog(context, "Please try again later!");
                        }
                    });
                  }
                }),
              ),
            ]
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _emailTextController.dispose();
    _managerNameTextController.dispose();
    super.dispose();
  }
}

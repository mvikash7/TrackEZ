import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_application/screens/home_screen.dart';
import 'package:first_application/screens/signup_screen.dart';
import 'package:first_application/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import '../widget/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _passwordVisible = true;
  final _formKeySignIn = GlobalKey<FormState>();

  final validator = Validator();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKeySignIn,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/images/fordlogo.png',
                  scale: 3,
                  ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 20),
                child: Text(
                  'TRACKEZ',
                  style: TextStyle(fontSize: 40),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top:10.0, bottom: 10),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 30),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:30.0, left: 15, right: 15, bottom: 20),
                child: TextFormField (
                  controller: _emailTextController,
                  decoration: reusableDecoration("Enter Username", Icons.person_outline),
                  validator: validator.validateEmail,
                  ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField (
                  controller: _passwordTextController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      labelText: "Enter Password",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                      )
                  ),
                  validator: validator.validateLoginPassword,
                  obscureText: !_passwordVisible,
                  ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                child: signInSignUpButton(context, true,() async {
                  if(_formKeySignIn.currentState!.validate()) {
                    Loader.show(context, progressIndicator: const CircularProgressIndicator(backgroundColor: Colors.blue,));
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text
                      ).then((value) => {
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()))
                      });
                    } on FirebaseAuthException catch (e) {
                      Loader.hide();
                      if (e.code == 'user-not-found') {
                        await showAlertDialog(context, 'Account Not Found!');
                        } else if (e.code == 'wrong-password') {
                        await showAlertDialog(context, 'Incorrect Password');
                        }
                      }
                  }
                }),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
                child: signUpOption(),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    if(validator.validateEmail(_emailTextController.text) == null) {
                      resetPassword(email: _emailTextController.text);
                    }
                    else {
                      showMaterialBanner(context, "Please enter your correct email-ID");
                    }
                  },
                  child: const Text("Forgot Password?",
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                ),
              )
            ]
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future resetPassword({required String email}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailTextController.text)
        .then((value) => {
        showMaterialBanner(context, "A email has been sent to your registered mail.")
    }).onError((error, stackTrace) => {
        showMaterialBanner(context, "An error occurred! Please try again later.")
    });
  }


  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?", style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(" Sign Up",
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
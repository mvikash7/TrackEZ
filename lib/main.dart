import 'package:firebase_core/firebase_core.dart';
import 'package:first_application/screens/home_screen.dart';
import 'package:first_application/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(home: status == true ? const HomeScreen() : const SignInScreen()));
}



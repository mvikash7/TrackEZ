import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_application/screens/admin_home_screen.dart';
import 'package:first_application/screens/employee_home_screen.dart';
import 'package:first_application/screens/manager_home_screen.dart';
import 'package:first_application/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? email = '';
  String? manager = '';
  String? name = '';
  String? userType = '';

  final pref = SharedPref();

  @override
  void initState() {
    super.initState();
    _getUserProfileFromCache();
    pref.cacheUserSignInstateToTrue();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'assets/images/fordlogo.png',
            scale: 4,
          ),
          const Center(child: Text(" TrackEZ")),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () async {
            final shouldLogout = await _showLogOutDialog(context);
            if (shouldLogout) {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()));
                pref.clearUserDataFromCache();
              });
            }
          },
        )
        ],
      ),
        body: Center(
          child: (
              userType == "admin" ? const Admin() : userType == "manager" ? const Manager() : const Employee()
          ),
        )
    );
  }


  Future<void> _getUserProfileDataFromFirebase() async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .get()
        .then((snapshot) {
       if(snapshot.exists) {
         setState(() {
           email = snapshot.data()!["email"].toString();
           manager  = snapshot.data()!["manager"].toString();
           name = snapshot.data()!["name"].toString();
           userType = snapshot.data()!["user type"].toString();

           pref.cacheUserProfileData(email!, manager!, name!, userType!);
         });
       }
    });
  }

  Future<void> _getUserProfileFromCache()  async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    manager = prefs.getString('manager');
    name = prefs.getString('userName');
    userType = prefs.getString('userType');

    if (userType == null) {
      _getUserProfileDataFromFirebase();
    }
  }

  Future<bool> _showLogOutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text('Are you sure want to log out?'),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop(false);
            },
              child: const Text('Cancel'),
            ),

            TextButton(onPressed: () {
              Loader.show(context,
                  progressIndicator: const CircularProgressIndicator(
                    backgroundColor: Colors.blue,));
              Future.delayed(const Duration(seconds: 1),() {
                Loader.hide();
                Navigator.of(context).pop(true);
              });
            },
              child: const Text('Log Out'),
            )
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}


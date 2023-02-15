import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String name, String managerName, String userType, String userEmail) async {
  CollectionReference user = FirebaseFirestore.instance.collection("users");
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  user.doc(uid).set({
    "id": uid,
    "name": name,
    "manager": managerName,
    "user type": userType,
    "email": userEmail
  });
}

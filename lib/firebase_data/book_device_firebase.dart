import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> bookDevice(
    String userEmail,
    String managerName,
    String deviceName,
    String fromDate,
    String toDate,
    String status) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  CollectionReference user = FirebaseFirestore.instance.collection("bookings");
  user.doc(uid).set({
    "id": uid,
    "email": userEmail,
    "manager": managerName,
    "device name": deviceName,
    "start date": fromDate,
    "end date": toDate,
    "status": status
  });
}

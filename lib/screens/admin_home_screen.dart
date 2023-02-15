import 'package:first_application/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            commonButton(context, "Book Device", () {
              //TODO
            }),
            commonButton(context, "User Management", () {
              //TODO
            }),
            commonButton(context, "Device Inventory", () {
              //TODO
            }),
            commonButton(context, "Reports", () {
              //TODO
            }),
          ]),
    );
  }
}
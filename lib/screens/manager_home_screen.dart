import 'package:first_application/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            commonButton(context, "Book Device", () {
              //TODO
            }),
            commonButton(context, "Approve/Deny", () {
              //TODO
            }),
            commonButton(context, "Transfer", () {
              //TODO
            }),
            commonButton(context, "My Team", () {
              //TODO
            }),
            commonButton(context, "Report", () {
              //TODO
            }),
          ]),
    );
  }
}
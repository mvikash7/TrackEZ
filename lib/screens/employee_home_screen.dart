import 'package:first_application/screens/book_device_screen.dart';
import 'package:flutter/material.dart';
import '../widget/reusable_widgets.dart';


class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            commonButton(context, "Book Device", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BookDeviceScreen()));
            }),
            commonButton(context, "Search", () {
              //TODO
            }),
            commonButton(context, "My Devices", () {
              //TODO
            }),
            commonButton(context, "History", () {
              //TODO
            }),
          ]),
    );
  }
}

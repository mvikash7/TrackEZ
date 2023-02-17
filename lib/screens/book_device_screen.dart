import 'package:first_application/firebase_data/book_device_firebase.dart';
import 'package:first_application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/reusable_widgets.dart';

class BookDeviceScreen extends StatefulWidget {
  const BookDeviceScreen({Key? key}) : super(key: key);

  @override
  State<BookDeviceScreen> createState() => _BookDeviceState();
}

class _BookDeviceState extends State<BookDeviceScreen>{
  String selectedDevice = "iPhone13";
  String? managerName = '';
  String? userEmail = '';
  final TextEditingController _fromDateInput = TextEditingController();
  final TextEditingController _toDateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserProfileDataFromCache();
  }

  @override
  void dispose() {
    _fromDateInput.dispose();
    _toDateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Book Device"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Select Device*"),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black12,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedDevice,
                  items: <String>['iPhone13', 'iPhone14 Pro', 'iPhone12', 'Pixel 7', 'Samsung S22']
                      .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? selectedValue) {
                    setState(() {
                      selectedDevice = selectedValue!;
                    });
                  },
                )
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Manager Name"),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text("$managerName")
                ),
              ),
            ),

           Padding(padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                controller: _fromDateInput,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: "Booking Date From*"
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101)
                  );
                  if(pickedDate != null ){
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      _fromDateInput.text = formattedDate;
                    });
                  }else{
                    print("Date is not selected");
                  }
                },
              )
           ),

            Padding(padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                controller: _toDateInput,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Booking Date To*"
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101)
                  );
                  if(pickedDate != null ){
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      _toDateInput.text = formattedDate;
                    });
                  }else{
                    print("Date is not selected");
                  }
                },
              )
            ),

             Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: commonButton(context, "Book Device", () async {
                  bookDevice(
                      userEmail!,
                      managerName!,
                      selectedDevice,
                      _fromDateInput.text,
                      _toDateInput.text,
                  "Awaiting approval").then((value) => {
                        showAlertDialog(context, "Booked Successfully!"),
                  }).onError((error, stackTrace) => {
                    showAlertDialog(context, "$error")
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                }),
            )
          ],
        ),
      )
    );
  }

  Future<void> _getUserProfileDataFromCache() async{
    final prefs = await SharedPreferences.getInstance();
    managerName = prefs.getString('manager');
    userEmail = prefs.getString('email');
  }
}
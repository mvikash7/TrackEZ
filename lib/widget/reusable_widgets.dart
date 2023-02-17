import 'package:flutter/material.dart';

Container signInSignUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(60, 10, 60, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
              isLogin ? 'SIGN IN' : 'SIGN UP',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
      ),
    );
}

Container commonButton(BuildContext context, String buttonText, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.only(top: 60, left: 80, right: 80, ),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

commonAppBar(BuildContext context, String pageName) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.blue,
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(pageName, style: const TextStyle(color: Colors.white)),
          ),
          Image.asset(
            'assets/images/fordlogo.png',
            scale: 4,
          )
        ],
      )
  );
}

showMaterialBanner(BuildContext context, String bannerText){
  ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
          elevation: 1,
          content: Text(bannerText),
          contentTextStyle: const TextStyle(color: Colors.white ,fontSize: 13),
          backgroundColor: Colors.blue,
          leading: const Icon(Icons.info, color: Colors.white),
          actions:[
            TextButton(onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('Dismiss', style: TextStyle(color: Colors.white))),
          ])
  );
}

InputDecoration reusableDecoration(String text, IconData icon) {
  return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)
      )
  );
}

Future<void> showAlertDialog(BuildContext context, String text){
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded, color: Colors.red, size: 50),
      content: Text(text, textAlign: TextAlign.center),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        },
          child: const Text('OK'),
        )
      ],
    );
  }) ;
}
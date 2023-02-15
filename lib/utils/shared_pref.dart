import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> cacheUserSignInstateToTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);
  }

  Future<bool> checkUserSignInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    return status;
  }

  Future<void> cacheUserProfileData(String email, String manager, String name, String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('manager', manager);
    await prefs.setString('name', name);
    await prefs.setString('userType', userType);
  }

  Future<void> clearUserDataFromCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
import 'package:shared_preferences/shared_preferences.dart';

import '../data/constants/prefs_string_constants.dart';

class AuthService {
  Future<SharedPreferences> get sharedPreferencies async => await SharedPreferences.getInstance();
  Future<bool> get loggedIn async => (await sharedPreferencies).getBool(PrefsStringConstants.loggedIn) ?? false;

  Future<void> login(String login, String password) async {
    // Login imitation
    return await Future.delayed(const Duration(seconds: 2), () async { 
      if (login == "demo" && password == "demo") {
        await saveLoggedInStatus();
      }
      else {
        return Future.error("Invalid email or password");
      }
    });
  }

  Future<void> logout() async => await Future.delayed(const Duration(seconds: 1), () async => await saveLoggedOutStatus());

  Future<void> saveLoggedInStatus() async {
    final prefs = await sharedPreferencies;
    await prefs.setBool(PrefsStringConstants.loggedIn, true);
  }

  Future<void> saveLoggedOutStatus() async {
    final prefs = await sharedPreferencies;
    await prefs.setBool(PrefsStringConstants.loggedIn, false);
  }
}
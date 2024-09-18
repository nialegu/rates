import '../data/constants/prefs_string_constants.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository{
  @override
  Function(Map<String, dynamic> json) get fromJson => (_) => {};
  @override
  String get queryName => "";
  @override
  String get nameSpace => "";

  Future<bool> get loggedIn async =>
      (await sharedPreferencies).getBool(PrefsStringConstants.loggedIn) ??
      false;

  Future<void> login(String login, String password) async {
    // Login imitation
    return await Future.delayed(const Duration(seconds: 2), () async {
      if (login == "demo" && password == "demo") {
        await saveLoggedInStatus();
      } else {
        return Future.error("Invalid email or password");
      }
    });
  }

  Future<void> logout() async => await Future.delayed(
      const Duration(seconds: 1), () async => await saveLoggedOutStatus());

  Future<void> saveLoggedInStatus() async {
    final prefs = await sharedPreferencies;
    await prefs.setBool(PrefsStringConstants.loggedIn, true);
  }

  Future<void> saveLoggedOutStatus() async {
    final prefs = await sharedPreferencies;
    await prefs.setBool(PrefsStringConstants.loggedIn, false);
  }
}

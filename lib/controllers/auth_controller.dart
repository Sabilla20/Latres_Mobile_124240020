import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';

class AuthController extends GetxController {
  final username = ''.obs;

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kPrefIsLoggedIn) ?? false;
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString(kPrefUsername) ?? '';
  }

  Future<bool> login(String user, String pass) async {
    if (user.trim() == kNim && pass == kPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(kPrefIsLoggedIn, true);
      await prefs.setString(kPrefUsername, user.trim());
      username.value = user.trim();
      Get.offAll(() => const MainPage());
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kPrefIsLoggedIn);
    await prefs.remove(kPrefUsername);
    username.value = '';
    Get.offAll(() => const LoginPage());
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/auth_controller.dart';
import 'controllers/favorite_controller.dart';
import 'core/constants.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive untuk favorit
  await Hive.initFlutter();
  await Hive.openBox(kFavoriteBox);

  // Controller global
  final auth = Get.put(AuthController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);

  // Cek session dari SharedPreferences
  final loggedIn = await AuthController.isLoggedIn();
  if (loggedIn) await auth.loadUser();

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFF44336);

    return GetMaterialApp(
      title: 'NontonSkuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: red, secondary: red),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: red,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade900,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: loggedIn ? const MainPage() : const LoginPage(),
    );
  }
}

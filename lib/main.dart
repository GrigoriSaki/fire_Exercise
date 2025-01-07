import 'package:fire_exercises/helperFunctions/auhFunc.dart';
import 'package:fire_exercises/homePage.dart';
import 'package:fire_exercises/loginPage.dart';

import 'package:fire_exercises/theme/dark_mode.dart';
import 'package:fire_exercises/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'profilePage.dart';
import 'usersPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthFunc(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        'profile page': (context) => ProfilePage(),
        'login page': (context) => LoginPage(),
        'home page': (context) => HomePage(),
        'users page': (context) => UsersPage(),
      },
    );
  }
}

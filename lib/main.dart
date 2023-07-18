import 'package:dhanush/screens/splashScreen1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'themes/themes_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhanush',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: splashScreen1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

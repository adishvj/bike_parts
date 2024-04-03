import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/workshop/workshop_home_screen.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF7C910)),
      home: LoginScreen(),
    );
  }
}

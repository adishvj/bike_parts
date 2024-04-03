import 'package:bike_parts/modules/auth/mechanic_reg.dart';
import 'package:bike_parts/modules/auth/signup_screen.dart';
import 'package:bike_parts/modules/auth/workshop_reg.dart';
import 'package:flutter/material.dart';



class ChooseRegistrationScreen extends StatelessWidget {
  const ChooseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Choose'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'User',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkShopRegistrations(),
                    ));
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_repair_service,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Work shop',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicRegistration(),));
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Mechanic',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

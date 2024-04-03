
import 'package:flutter/material.dart';


class MechanicHomeScreen extends StatelessWidget {
  const MechanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
       
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              child: ListTile(
                leading:
                    const Icon(Icons.app_registration, color: Colors.black),
                title: const Text('Add Touranament',
                    style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                 
                },
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.grass, color: Colors.black),
                title: const Text('View turfs',
                    style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  
                },
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.festival, color: Colors.black),
                title: const Text('View Tournaments',
                    style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                 
                },
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.black),
                title: const Text('Booking',
                    style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                 
                },
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.black),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

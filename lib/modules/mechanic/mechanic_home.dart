
import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/mechanic/mech_update_part.dart';
import 'package:bike_parts/modules/mechanic/mechanic_add_parts.dart';
import 'package:bike_parts/modules/mechanic/profile/mech_profile_screen.dart';
import 'package:bike_parts/modules/mechanic/view_parts.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';


class MechanicHomeScreen extends StatelessWidget {
  const MechanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    print(DbService.getWorkshopId());
    return Scaffold(

      extendBodyBehindAppBar: true,
      
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.transparent),
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
       
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/pexels-rachel-claire-4577448.jpg'))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                child: ListTile(
                  leading:
                      const Icon(Icons.settings, color: Colors.black),
                  title: const Text('View parts',
                      style: TextStyle(color: Colors.black)),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const MechanicViewPartsScreen(),));
                   
                  },
                ),
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.grass, color: Colors.black),
                  title: const Text('Add parts',
                      style: TextStyle(color: Colors.black)),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MechAddPartsScreen(),));
                    
                  },
                ),
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.festival, color: Colors.black),
                  title: const Text('Update parts',
                      style: TextStyle(color: Colors.black)),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicUpdatePartsScreen(),));
                   
                  },
                ),
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.black),
                  title: const Text('Profile',
                      style: TextStyle(color: Colors.black)),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MechProfileScreen(),));


                   
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

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

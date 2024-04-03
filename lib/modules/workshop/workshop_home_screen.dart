import 'package:bike_parts/utils/constants.dart';
import 'package:flutter/material.dart';

class  WorkShopHomeScreen extends StatefulWidget {

  const WorkShopHomeScreen({super.key});

  @override
  State<WorkShopHomeScreen> createState() => _WorkShopHomeScreenState();
}

class _WorkShopHomeScreenState extends State<WorkShopHomeScreen> {
bool isAttend = false;

bool loading = false;


  
@override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView(
                  // Set the number of items in the grid
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 20.0, // Spacing between columns
                    mainAxisSpacing: 20.0, // Spacing between rows
                  ),
                 children: [
               
               
                  
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'Mechanic', // Name of the item
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/approve.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                   GestureDetector(
                      onTap: () {
                      
                        // Add your navigation logic here
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'View parts', // Name of the item
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/parts.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                   
                     GestureDetector(
                      onTap: () {
                      
                        // Add your navigation logic here
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'View bikes', // Name of the item
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/bikes.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                   
                   GestureDetector(
                      onTap: () {
                     
                      },
                      child: Container(
                        
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'Logout', // Name of the item
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Container(
                            color: Colors.white,
                            child: const Icon(Icons.logout,color: Colors.red,size: 50,)),
                        ),
                      ),
                    ),

              
                 ],
                ),
              ),
            
            
            ],
          ),
        ),
      
    );
  }
}
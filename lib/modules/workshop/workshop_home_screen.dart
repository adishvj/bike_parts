import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/workshop/profile/work_shop_profile.dart';
import 'package:bike_parts/modules/workshop/vieworders.dart';
import 'package:bike_parts/modules/workshop/work_shop_all_bike_bookings.dart';
import 'package:bike_parts/modules/workshop/workshop_add_bike.dart';
import 'package:bike_parts/modules/workshop/workshop_review_screen.dart';
import 'package:bike_parts/modules/workshop/workshop_view_all_bikes.dart';
import 'package:bike_parts/modules/workshop/workshop_view_all_mech.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/utils/constants.dart';
import 'package:flutter/material.dart';

class WorkShopHomeScreen extends StatefulWidget {
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
    print(DbService.getWorkshopId());
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkshopViewAllMechanicsScreen(),
                          ));
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkshopAddBikes(),
                          ));

                      // Add your navigation logic here
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Add bikes', // Name of the item
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkShopRentBikesView(),
                          ));

                      // Add your navigation logic here
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkShopProfileScreen(),
                          ));

                      // Add your navigation logic here
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Profile', // Name of the item
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRPFBU-zohtrnntceQIYCsbuaCoIFj0FzBh39kWcfZRZIDp0-y_fxZfQsac7HonmgRpZE&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkshopViewAllBookingsScreen(),
                          ));

                      // Add your navigation logic here
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Bike bookings', // Name of the item
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/bike.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkShopReviewScreen(),
                          ));

                      // Add your navigation logic here
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Reviews', // Name of the item
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZCKQ97MaMybGx9viwaDq41qUtf3yB1Z2EIAY1Sb8o5VhmaVpsuVRdqnzVxrAnbkm7fWA&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkShopOrderscreen(),
                          ));

                      // Add your navigation logic here
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'View Orders', // Name of the item
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Image.network(
                          'https://5.imimg.com/data5/SELLER/Default/2023/7/327315640/IJ/AL/MJ/11609455/hero-bike-spare-parts.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: GridTile(
                        footer: Container(
                          color: KButtonColor,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Logout', // Name of the item
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Container(
                            color: Colors.white,
                            child: const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 50,
                            )),
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

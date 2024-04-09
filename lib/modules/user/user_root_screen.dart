import 'package:bike_parts/modules/user/home/user_home_screen.dart';
import 'package:bike_parts/modules/user/profile/user_profile_screen.dart';
import 'package:bike_parts/modules/user/spareparts/user_spare_parts_screen.dart';
import 'package:bike_parts/modules/user/user_booking_list_screen.dart';
import 'package:bike_parts/modules/user/workshop/user_work_shop_screen.dart';
import 'package:flutter/material.dart';

class UserRootScreen extends StatefulWidget {
  const UserRootScreen({super.key});

  @override
  State<UserRootScreen> createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pagesList = [
    const HomeScreen(),
    const UserSparePartsScreen(),
    UserBookingList(),
    const UserWorkShopScreen(),
    UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _pagesList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xffED1C24),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: 'Spare parts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction),
            label: 'Work shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

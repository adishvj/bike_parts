import 'package:bike_parts/modules/user/cart/user_cart_screen.dart';
import 'package:bike_parts/modules/user/home/widgets/popular_parts_widget.dart';
import 'package:bike_parts/modules/user/home/widgets/popular_workshop_widget.dart';
import 'package:bike_parts/modules/user/search/user_search_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            backgroundColor: const Color(0xfff7c910),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  UserSearchScreen(),
                    ));
              },
              icon: const Icon(Icons.search),
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  UserCartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ],
          ),

          const SizedBox(
            height: 30,
          ),
          //slider
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.amber),
            child: CarouselSlider(
              options: CarouselOptions(autoPlay: true, viewportFraction: 1),
              items: [
                'https://img.freepik.com/free-photo/mechanic-repairing-bicycle_23-2148138617.jpg?w=1380&t=st=1708497923~exp=1708498523~hmac=db0aa97cb4ebd6cb6b1a4e4f5a8da5d25d20e4a8be9b4bb5abeb10a7cbbcc7d0',
                'https://img.freepik.com/free-photo/mechanic-repairing-bicycle_23-2148138617.jpg?w=1380&t=st=1708497923~exp=1708498523~hmac=db0aa97cb4ebd6cb6b1a4e4f5a8da5d25d20e4a8be9b4bb5abeb10a7cbbcc7d0'
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(i),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 30),
                          )),
                    );
                  },
                );
              }).toList(),
            ),
          )
          //slider view part
          ,
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Text(
                  'Popular parts',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),

         Container(
          height: 250,
            padding: const EdgeInsets.only(left: 10),
            child: PopularWidget(),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Text(
                  'Popular workshop',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          

          Container(
            height: 250,
            padding: const EdgeInsets.only(left: 10),
            child: PopularWorkWidget(),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

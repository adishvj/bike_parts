import 'package:bike_parts/modules/user/home/widgets/popular_parts_widget.dart';
import 'package:bike_parts/modules/user/home/widgets/popular_workshop_widget.dart';
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
    return Scaffold(
      backgroundColor:  Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            //slider
            Container(
              clipBehavior: Clip.hardEdge,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), color: Colors.amber),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Popular parts',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  
                 
                ],
              ),
            ),
            
            
             PopularWidget(),

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Popular workshop',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Spacer(),
                 
                
                ],
              ),
            ),
            
            
             PopularWorkWidget()
            
         
         
          ],
        ),
      ),
    );
  }
}

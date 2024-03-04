import 'package:bike_parts/modules/user/cart/user_cart_screen.dart';
import 'package:flutter/material.dart';

class PopularWidget extends StatelessWidget {
  PopularWidget({super.key});

  final partList = [
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png',
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png',
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: partList.length,
        itemBuilder: (context, index) => Card(
          child: SizedBox(
            width: 160,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        partList[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Engin parts',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '170 OMA',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserCartScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xffF7C910),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      'ADD TO CART',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

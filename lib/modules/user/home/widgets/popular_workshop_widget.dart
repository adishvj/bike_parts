
import 'package:flutter/material.dart';

class PopularWorkWidget extends StatelessWidget {
  PopularWorkWidget({super.key});

  final partList = [
    
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png',
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
                
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xffF7C910),
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: const Text(
                    'SHOP NAME',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
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

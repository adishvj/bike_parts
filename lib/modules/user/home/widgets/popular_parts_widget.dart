import 'dart:convert';

import 'package:bike_parts/modules/user/cart/user_cart_screen.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PopularWidget extends StatefulWidget {
  PopularWidget({super.key});

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  final partList = [
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png',
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png',
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'
  ];

    late Future<List<dynamic>> _partsListFuture;

  @override
  void initState() {
    super.initState();
    _partsListFuture = _fetchPartsList();
  }

   Future<List<dynamic>> _fetchPartsList() async {
    final response = await http.get(Uri.parse('${ApiService.baseUrl}/api/user/view-all-parts'));
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load parts list');
    }
  }

  bool _loading =  false;

   @override
  Widget build(BuildContext context) {
    return _loading ?  Center(child: CircularProgressIndicator(),)  : FutureBuilder<List<dynamic>>(
        future: _partsListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Text('loding.....');
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> partList = snapshot.data!;
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
                                partList[index]['parts_image'][0],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                         Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                partList[index]['part_name'],
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
                                 partList[index]['rate'],
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
                          onTap: ()  async{
                            

                            await ApiService().addPartsToCart(
                              loginId: DbService.getLoginId()!, 
                              partId:  partList[index]['_id'], 
                              price:     partList[index]['rate'], context: context);
                          
                            
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
                                fontWeight: FontWeight.w500,
                              ),
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
        },
      );
   
  }
}

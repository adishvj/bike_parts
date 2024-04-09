import 'dart:convert';

import 'package:bike_parts/modules/user/workshop/user_work_shop_details.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularWorkWidget extends StatefulWidget {
  PopularWorkWidget({super.key});

  @override
  State<PopularWorkWidget> createState() => _PopularWorkWidgetState();
}

class _PopularWorkWidgetState extends State<PopularWorkWidget> {
  final partList = [
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png',
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'
  ];

  late Future<List<dynamic>> _workshopListFuture;

  @override
  void initState() {
    super.initState();
    _workshopListFuture = _fetchWorkshopList();
  }

  Future<List<dynamic>> _fetchWorkshopList() async {
    final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/register/view-all-workshops'));
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load workshop list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder<List<dynamic>>(
        future: _workshopListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(' ${snapshot.error}'));
          } else {
            List<dynamic> workshopList = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: workshopList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserWorkShopDetails(
                        details: workshopList[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                partList[0],
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
                          child: Text(
                            workshopList[index]['workshop_name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
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
      ),
    );
  }
}

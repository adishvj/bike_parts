import 'dart:convert';

import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkShopOrderscreen extends StatefulWidget {
  const WorkShopOrderscreen({Key? key}) : super(key: key);

  @override
  State<WorkShopOrderscreen> createState() => _WorkShopOrderscreenState();
}

class _WorkShopOrderscreenState extends State<WorkShopOrderscreen> {
  Future<List<Map<String, dynamic>>> _fetchOrder(String workshopId) async {
    final url = Uri.parse(
        'https://vadakara-mca-bike-backend.onrender.com/api/workshop/view-orders/$workshopId');
    final response = await http.get(url);
    print("dhh---------------------------------------");
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _fetchOrder(DbService.getWorkshopId()!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final reviews = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['part_name'] ?? 'Anonymous',
                            style: TextStyle(color: Colors.grey)),
                        Divider(
                          color: Colors.black,
                          endIndent: 10,
                        ),
                        Text("Quantity: ${review['quantity']}",
                            style: TextStyle(color: Colors.grey)),

                        Text("Rate: ${review['rate']}",
                            style: TextStyle(color: Colors.grey)),

                        Text("Subtotal: ${review['subtotal']}",
                            style: TextStyle(color: Colors.grey)),

                        Text("Status: ${review['status']}",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 20.0),
                        Image.network(
                          review['parts_image'][0],
                          width: 100,
                          height: 100,
                        ),

                        // Text(review['review'] ?? 'No review'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

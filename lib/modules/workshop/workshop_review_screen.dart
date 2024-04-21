import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkShopReviewScreen extends StatefulWidget {
  const WorkShopReviewScreen({Key ? key}) : super(key: key);

  @override
  State<WorkShopReviewScreen> createState() => _WorkShopReviewScreenState();
}

class _WorkShopReviewScreenState extends State<WorkShopReviewScreen> {
  Future<List<Map<String, dynamic>>> _fetchReviews(String workshopId) async {
    final url = Uri.parse('https://vadakara-mca-bike-backend.onrender.com/api/workshop/view-review/$workshopId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    final workshopId = 'your_workshop_id_here'; // Replace with actual workshop ID
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _fetchReviews(DbService.getWorkshopId()!),
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
                        Text(review['user']['name'] ?? 'Anonymous', style: TextStyle(color: Colors.grey)),
                        Divider(
                          color: Colors.black,
                          endIndent: 10,
                        ),
                        Text(review['review'] ?? 'No review'),
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
 
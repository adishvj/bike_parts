import 'package:bike_parts/modules/user/workshop/user_bike_details.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RentBikesView extends StatelessWidget {
  const RentBikesView({super.key});

  Future<List<dynamic>> _fetchBikes() async {
    final response = await http.get(Uri.parse('${ApiService.baseUrl}/api/user/view-all-bikes'));
    if (response.statusCode == 200) {

      print(response.body);
      return json.decode(response.body)["data"];
    } else {
      throw Exception('Failed to load bikes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchBikes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> bikes = snapshot.data!;
            return ListView.builder(
              itemCount: bikes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(bikes[index]['bike_image'][0]),
                  ),
                  title: Center(
                    child: Text(bikes[index]['bike_name']),
                  ),
                  trailing: CustomButton(
                    text: 'View',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserBikeScreen(
                            image: bikes[index]['bike_image'][0],
                            details: bikes[index],
                          ),
                        ),
                      );
                    },
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

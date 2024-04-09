import 'dart:convert';

import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkshopViewAllMechanicsScreen extends StatefulWidget {
  const WorkshopViewAllMechanicsScreen({Key? key}) : super(key: key);

  @override
  State<WorkshopViewAllMechanicsScreen> createState() => _WorkshopViewAllMechanicsScreenState();
}

class _WorkshopViewAllMechanicsScreenState extends State<WorkshopViewAllMechanicsScreen> {
  Future<List<dynamic>> fetchWorkshopMechanics(String workshopId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}/api/register/workshop-view-all-registered-mechanics/$workshopId'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = jsonDecode(response.body)['data'];

      print(data);
      return data;
    } else {
      // If the server returns an error response, throw an exception.
      throw Exception('Failed to load workshop mechanics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Workshop Mechanics'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMechanicsList(context, 'your_workshop_id_here', 'pending'),
            _buildMechanicsList(context, 'your_workshop_id_here', 'accepted'),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicsList(BuildContext context, String workshopId, String status) {
    return FutureBuilder(
      future: fetchWorkshopMechanics(workshopId),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> mechanicsList = snapshot.data!;
          // Filter mechanics based on status
          List<dynamic> filteredMechanics = mechanicsList.where((mechanic) => mechanic['status'] == status).toList();
          return GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: .55,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            children: List.generate(
              filteredMechanics.length,
              (index) => GestureDetector(
                onTap: () {
                  // Navigate to mechanic details screen
                },
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          filteredMechanics[index]['mechanic_image'],
                          fit: BoxFit.fill,
                          height: 120,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredMechanics[index]['mechanic_name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  text: 'Accept',
                                  color: Colors.amber,
                                  onPressed: () async{
                                    setState(() {
                                      
                                    });

                                    await ApiService().approveMechanic(context, DbService.getLoginId()!);

                                    
                                    setState(() {
                                      
                                    });
                                  },
                                ),
                                CustomButton(
                                  text: 'Reject',
                                  color: Colors.amber,
                                  onPressed: ()  async{

                                    setState(() {
                                      
                                    });

                                    await  ApiService().rejectMechanic(context, DbService.getLoginId()!);

                                    setState(() {
                                      
                                    });
                                    // Implement reject mechanic logic
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
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

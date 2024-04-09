import 'dart:convert';

import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkshopViewAllMechanicsScreen extends StatefulWidget {
  const WorkshopViewAllMechanicsScreen({Key? key}) : super(key: key);

  @override
  State<WorkshopViewAllMechanicsScreen> createState() =>
      _WorkshopViewAllMechanicsScreenState();
}

class _WorkshopViewAllMechanicsScreenState
    extends State<WorkshopViewAllMechanicsScreen> {
  Future<List<dynamic>> fetchWorkshopMechanics(String workshopId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}/api/register/workshop-view-all-registered-mechanics/${DbService.getWorkshopId()}'),
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
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
            _buildMechanicsList(context, DbService.getWorkshopId()!, '0'),
            _buildMechanicsList(
                context, DbService.getWorkshopId()!, '1'),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicsList(
      BuildContext context, String workshopId, String status) {
    return FutureBuilder(
      future: fetchWorkshopMechanics(workshopId),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot,) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> mechanicsList = snapshot.data!;
          // Filter mechanics based on status
                     mechanicsList = mechanicsList.where((mechanic) => mechanic['status'] == status).toList();

          return ListView(
            children: List.generate(
              mechanicsList.length,
              (index) => GestureDetector(
                onTap: () {
                  // Navigate to mechanic details screen
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Icon(
                            Icons.person,
                            size: 60,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mechanicsList[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            mechanicsList[index]['mobile'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomButton(
                        text: 'Accept',
                        color: Colors.amber,
                        onPressed: () async {
                          setState(() {});

                          await ApiService().approveMechanic(
                              context, mechanicsList[index]['login_id']);

                          setState(() {});
                        },
                      ),
                      SizedBox(width: 10,),
                      CustomButton(
                        text: 'Reject',
                        color: Colors.amber,
                        onPressed: () async {
                          setState(() {});

                          await ApiService()
                              .rejectMechanic(context, DbService.getLoginId()!);

                          setState(() {});
                          // Implement reject mechanic logic
                        },
                      ),
                      const SizedBox(
                        height: 10,
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

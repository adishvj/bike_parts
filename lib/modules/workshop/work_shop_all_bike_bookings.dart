import 'dart:convert';

import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkshopViewAllBookingsScreen extends StatefulWidget {
  const WorkshopViewAllBookingsScreen({Key? key}) : super(key: key);

  @override
  State<WorkshopViewAllBookingsScreen> createState() =>
      _WorkshopViewAllBookingsScreenState();
}

class _WorkshopViewAllBookingsScreenState
    extends State<WorkshopViewAllBookingsScreen> {
  Future<List<dynamic>> fetchWorkshopMechanics(String workshopId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}/api/workshop/view-all-bike-booking/${DbService.getWorkshopId()}'),
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = jsonDecode(response.body)['data'];

      print(data);
      return data;
    } else {
      // If the server returns an error response, throw an exception.
      return [];
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
            _buildMechanicsList(context, DbService.getWorkshopId()!, 0),
            _buildMechanicsList(context, DbService.getWorkshopId()!, 1),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicsList(
      BuildContext context, String workshopId, int status) {
    return FutureBuilder(
      future: fetchWorkshopMechanics(workshopId),
      builder: (
        context,
        AsyncSnapshot<List<dynamic>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('No data'));
        } else {
          List<dynamic> mechanicsList = snapshot.data!;
          // Filter mechanics based on status
          mechanicsList = mechanicsList
              .where((mechanic) => mechanic['status'] == status)
              .toList();

          return mechanicsList.isEmpty
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'bike',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '2345678',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      if(status != 1)
                      CustomButton(
                        text: 'Accept',
                        color: Colors.amber,
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Accepted')));

                          setState(() {});
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if(status != 1)
                      CustomButton(
                        text: 'Reject',
                        color: Colors.amber,
                        onPressed: () async {
                          setState(() {});

                          // await ApiService()
                          //     .rejectMechanic(context, DbService.getLoginId()!);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Rejected')));

                          setState(() {});
                          // Implement reject mechanic logic
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ))
              : ListView(
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

                                await acceptBikeBooking(
                                    context, mechanicsList[index]['_id']);

                                setState(() {});
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              text: 'Reject',
                              color: Colors.amber,
                              onPressed: () async {
                                setState(() {});

                                rejectBooking(
                                    context, mechanicsList[index]['_id']);

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

  Future<void> acceptBikeBooking(BuildContext context, String bookingId) async {
    final url = Uri.parse(
        'https://vadakara-mca-bike-backend.onrender.com/api/workshop/accept-bike-booking/$bookingId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking accepted successfully')),
        );
        // Handle the response data if needed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to accept booking. Status code: ${response.statusCode}')),
        );
        // Handle the error
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception while accepting booking: $e')),
      );
      // Handle the exception
    }
  }

//reject booking

  Future<void> rejectBooking(BuildContext context, String bookingId) async {
    final url = Uri.parse(
        'https://vadakara-mca-bike-backend.onrender.com/api/workshop/reject-bike-booking/$bookingId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking accepted successfully')),
        );
        // Handle the response data if needed
      } else {
        throw Exception(
            'Failed to accept booking. Status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception while accepting booking: $e')),
      );
      // Handle the exception
    }
  }
}

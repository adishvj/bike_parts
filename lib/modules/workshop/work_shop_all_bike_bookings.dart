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

    print(DbService.getWorkshopId());

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
          title: Text('Bike Bookings'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMechanicsList(context, DbService.getWorkshopId()!, 'pending'),
            _buildMechanicsList(
                context, DbService.getWorkshopId()!, 'confirmed'),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicsList(
      BuildContext context, String workshopId, String status) {
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

          print(mechanicsList);

          return mechanicsList.isEmpty
              ? Center(
                  child: Text('No bookings'),
                )
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
                                child: Image.network(
                                  mechanicsList[index]['bike_image'][0],
                                  height: 50,
                                  width: 50,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    mechanicsList[index]['bike_name'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  mechanicsList[index]['pickup_date'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  mechanicsList[index]['dropoff_date'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  mechanicsList[index]['pickup_time'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            if (status == 'pending')
                              CustomButton(
                                text: 'Accept',
                                color: Colors.amber,
                                onPressed: () async {
                                  await acceptBikeBooking(
                                      context, mechanicsList[index]['_id']);

                                  setState(() {});
                                },
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            if (status == 'pending')
                              CustomButton(
                                text: 'Reject',
                                color: Colors.amber,
                                onPressed: () async {
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
        print(response.body);
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
    print(bookingId);
    final url = Uri.parse(
        'https://vadakara-mca-bike-backend.onrender.com/api/workshop/reject-bike-booking/$bookingId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking Rejected successfully')),
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

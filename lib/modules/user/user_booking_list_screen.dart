import 'dart:convert';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserBookingList extends StatefulWidget {


  UserBookingList({Key? key}) : super(key: key);

  @override
  _UserBookingListState createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  late Future<List<dynamic>> futureAppointments;
  late Future<List<dynamic>> futureDocServiceList;

  @override
  void initState() {
    super.initState();
    futureDocServiceList = _fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('User Booking List',style: TextStyle(color:Colors.black),),
          bottom: const TabBar(
            dividerColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Orders'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // FutureBuilder<List<dynamic>>(
            //   future: ApiServiece().fetchOrdes(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else {
            //       print(snapshot.data!);

            //       List<dynamic> orders = snapshot.data!;
            //       return ListView.builder(
            //         itemCount: orders.length,
            //         itemBuilder: (context, index) {
            //           return Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 8.0, horizontal: 20),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.teal),
            //               ),
            //               child: ListTile(
            //                 leading: const Icon(Icons.event),
            //                 title: Text(orders[index]['login_data']['email']),
            //                 subtitle:
            //                     Text('Price: ${orders[index]['order_status']}'),
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
            // // Placeholder for Service Booking tab
            // FutureBuilder<List<dynamic>>(
            //   future: ApiServiece().fetchServiceBookings(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else {
            //       List<dynamic> serviceBookings = snapshot.data!;
            //       return ListView.builder(
            //         itemCount: serviceBookings.length,
            //         itemBuilder: (context, index) {
            //           final booking = serviceBookings[index];
            //           return Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 8.0, horizontal: 20),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.teal),
            //               ),
            //               child: ListTile(
            //                 leading: const Icon(Icons.event),
            //                 title: Text('Date ${serviceBookings[index]["date"]}'),

            //               ),
            //             ),
            //           );
            //         },
            //       );

            //     }
            //   },
            // ),
            // // Placeholder for Doctor Booking tab

            // FutureBuilder<List<dynamic>>(
            //     future: futureDocServiceList,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //             child: CircularProgressIndicator(
            //           color: Colors.teal,
            //         ));
            //       } else if (snapshot.hasError) {
            //         return Center(child: Text('Error: ${snapshot.error}'));
            //       } else {
            //         return snapshot.data!.length == 0
            //             ? const Center(
            //                 child: Text('no  data'),
            //               )
            //             : ListView.builder(
            //                 itemCount: snapshot.data!.length,
            //                 itemBuilder: (context, index) {
            //                   final appointment = snapshot.data![index];

            //                   return Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         vertical: 8.0, horizontal: 20),
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                         border: Border.all(color: Colors.teal),
            //                       ),
            //                       child: ListTile(
            //                         leading: const Icon(Icons.event),
            //                         title: const Text('Product'),
            //                         subtitle: const Text('Price:'),
            //                         trailing: CustomButton(
            //                           onPressed: () {},
            //                           text: 'View More',
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               );
            //       }
            //     })

            FutureBuilder<List<dynamic>>(
              future: _fetchBookings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> serviceBookings = snapshot.data!;
                  return ListView.builder(
                    itemCount: serviceBookings.length,
                    itemBuilder: (context, index) {
                      final booking = serviceBookings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.event),
                            title: Text('Date ${booking["date"]}'),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }



  Future<List<dynamic>> _fetchBookings() async {

    print(DbService.getLoginId());
    final response = await http.get(Uri.parse('${ApiService.baseUrl}/api/user/view-all-bike/booking/${DbService.getLoginId()}'));
     print(response.body);
     print(response.statusCode);
    
    if (response.statusCode == 200) {

     
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}

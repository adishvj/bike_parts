import 'dart:convert';

import 'package:bike_parts/modules/user/workshop/user_work_shop_details.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserWorkShopScreen extends StatefulWidget {
  const UserWorkShopScreen({Key? key}) : super(key: key);

  @override
  _UserWorkShopScreenState createState() => _UserWorkShopScreenState();
}

class _UserWorkShopScreenState extends State<UserWorkShopScreen> {
  final _searchController = TextEditingController();
  late Future<List<dynamic>> _workshopsFuture;

  @override
  void initState() {
    super.initState();
    _workshopsFuture = fetchWorkshops();
  }

  Future<List<dynamic>> fetchWorkshops() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/register/view-all-workshops'),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load workshops');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _workshopsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  List<dynamic> workshops = snapshot.data ?? [];
                  print('workshops');
                  print(workshops);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: .55,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      children: workshops.map((workshop) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            width: 160,
                            child: Card(
                              child: SizedBox(
                                width: 160,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(workshop[
                                                      'images'] !=
                                                  null
                                              ? workshop['images'][0]
                                              : 'https://img.freepik.com/free-photo/mechanic-repairing-bicycle_23-2148138617.jpg?w=1380&t=st=1708497923~exp=1708498523~hmac=db0aa97cb4ebd6cb6b1a4e4f5a8da5d25d20e4a8be9b4bb5abeb10a7cbbcc7d0'),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      workshop['workshop_name'] ?? 'workshop',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      workshop['mobile'] ?? '1234567890',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserWorkShopDetails(
                                                    details: workshop),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: const Color(0xffF7C910),
                                        padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'View more',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                 
                                 SizedBox(height: 10,),
                                   GestureDetector(
                                      onTap: () {

                                        addReview(
                                          context, 
                                          DbService.getLoginId()!,
                                          workshop['_id']  
                                          );


                                        
                                       
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: const Color(0xffF7C910),
                                        padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Add Review',
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
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }




  Future<void> addReview(BuildContext context, String loginId, String workshopId) async {
  TextEditingController reviewController = TextEditingController();

  bool load = false;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Review'),
        content: load == true ?  CircularProgressIndicator()  : SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: reviewController,
                decoration: InputDecoration(labelText: 'Review'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Submit'),
            onPressed: () async {

              setState(() {
                load = true;
              });
             
              String review = reviewController.text;
              await postReview(context, loginId, workshopId, review);
               Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}




Future<void> postReview(BuildContext context, String loginId, String workshopId, String review) async {
  final url = Uri.parse('https://vadakara-mca-bike-backend.onrender.com/api/user/add-review');

  print('ggggg');
  final response = await http.post(
    url,
    body: {
      'login_id': loginId,
      'workshop_id': workshopId,
      'review': review,
    },
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review added successfully')),
    );
    // Handle the response data if needed
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add review. Status code: ${response.statusCode}')),
    );
    // Handle the error
  }
}





}

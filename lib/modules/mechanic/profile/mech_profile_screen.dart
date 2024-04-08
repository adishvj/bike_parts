import 'dart:convert';

import 'package:bike_parts/modules/mechanic/profile/mech_edit_profile.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MechProfileScreen extends StatefulWidget {


  const MechProfileScreen({Key? key}) : super(key: key);

  @override
  _MechProfileScreenState createState() => _MechProfileScreenState();
}

class _MechProfileScreenState extends State<MechProfileScreen> {
  late Future<Map<String, dynamic>> _mechanicFuture;

  @override
  void initState() {
    super.initState();
    _mechanicFuture = _fetchMechanicData();
  }

  Future<Map<String, dynamic>> _fetchMechanicData() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/register/view-single-mechanic/${DbService.getLoginId()!}'),
    );

    if (response.statusCode == 200) {

      print('profile${response.body}');
      return jsonDecode(response.body)["data"];
    } else {
      throw Exception('Failed to load mechanic data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _mechanicFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final mechanicData = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      hintText: 'name',
                      controller: TextEditingController(text: mechanicData['name']),
                      isEnabled: false,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      hintText: 'email',
                      controller: TextEditingController(text: mechanicData['mobile']),
                      isEnabled: false,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      hintText: 'phone',
                      controller: TextEditingController(text: mechanicData['qualification']),
                      isEnabled: false,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                      text: 'Edit',
                      color: Colors.amber,
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => MechEditProfileScreen(
                          name: mechanicData['name'],
                          phone: mechanicData['mobile'],
                          qualifiation: mechanicData['qualification'],
                        ),));
                        // Handle edit button press
                      },
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

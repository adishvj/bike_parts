import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/user/profile/user_edit_profile.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future<Map<String, dynamic>> _getUserData(String loginId) async {
    String url = '${ApiService.baseUrl}/api/register/view-single-user/$loginId';

    print(url);

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provide the login id here

    return FutureBuilder(
      future: _getUserData(DbService.getLoginId()!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var userData = snapshot.data;
          print(userData);
          _nameController.text = userData!['name'];
          _emailController.text = userData['mobile'];
          _phoneController.text = userData['address'];

          return Center(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                        onPressed: () async{
                         var refprof =  await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserEditProfileScreen(
                                name: _nameController.text,
                                address: _emailController.text,
                                phone: _phoneController.text,
                              ),
                            ),
                          );
                        setState(() {
                          
                        });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.red,
                        ))
                  ],
                ),
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hintText: 'name',
                    controller: _nameController,
                    isEnabled: false,
                    borderColor: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hintText: 'email',
                    controller: _emailController,
                    isEnabled: false,
                    borderColor: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hintText: 'phone',
                    controller: _phoneController,
                    isEnabled: false,
                    borderColor: Colors.grey.shade500,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'Logout',
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen()
                      ,), (route) => false);
                    },
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

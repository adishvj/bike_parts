import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MechEditProfileScreen extends StatefulWidget {
  MechEditProfileScreen({super.key, required this.name, required this.qualifiation, required this.phone});


  final String name;
  final String qualifiation;
  final String phone;

  @override
  State<MechEditProfileScreen> createState() => _MechEditProfileScreenState();
}

class _MechEditProfileScreenState extends State<MechEditProfileScreen> {
final nameController = TextEditingController();

final qualificationController = TextEditingController();

final phoneController = TextEditingController();

bool loading = false;

@override
  void initState() {

    nameController.text = widget.name;
    qualificationController.text = widget.qualifiation;
    phoneController.text = widget.phone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: loading ? CircularProgressIndicator()  : Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
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
                controller: nameController,
                
                borderColor: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'qualification',
                controller: qualificationController,
                
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
                controller: phoneController,
              
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
                text: 'Confirm',
                color: Colors.amber,
                onPressed: () async{
                  setState(() {
                    loading = true;
                  });

                 await  ApiService().updateMechanicProfile(
                    context: context, 
                    loginId: DbService.getLoginId()!, 
                    name: nameController.text,
                     phone: phoneController.text,
                      qualification: qualificationController.text);
                setState(() {
                  loading = false;
                });
                


                 
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> fetchAndUpdateMechanicProfile(BuildContext context, String apiUrl, String loginId, List<Map<String, dynamic>> queryParams) async {
  try {
    // Construct the query string from the list of query parameters
    
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/mechanic/update-mechanic-profile/${DbService.getLoginId()}'),

      headers: {
        
      }
    
    
    );

    if (response.statusCode == 200) {


      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Updated!!!'),
      ),


    );

    Navigator.pop(context);
     
      // Use mechanicProfile data as neede
    } else {
      throw Exception('Failed to load mechanic profile');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }
}
}

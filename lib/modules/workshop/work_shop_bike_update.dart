import 'dart:convert';

import 'package:bike_parts/modules/mechanic/mech_parts_details.dart';
import 'package:bike_parts/modules/mechanic/mech_update_confirmation.dart';
import 'package:bike_parts/modules/workshop/work_shop_bike_update_confirmation.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class WorkShopUpdatePartsScreen extends StatelessWidget {
  const WorkShopUpdatePartsScreen({super.key});




  Future<List<dynamic>> fetchMechanicParts(String workshopId) async {
  final response = await http.get(
    Uri.parse('${ApiService.baseUrl}/api/mechanic/view-all-parts/$workshopId'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    List<dynamic> data = jsonDecode(response.body)['data'];

    
    return data;
  } else {
    // If the server returns an error response, throw an exception.
    throw Exception('Failed to load mechanic parts');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,



      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        
        child: FutureBuilder(
        future: fetchMechanicParts(DbService.getWorkshopId()!),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> _filteredMedicineList = snapshot.data!;
          return GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: .55,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            children: List.generate(
              _filteredMedicineList.length,
              (index) => GestureDetector(
                onTap: () {
                   Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => MechanicPartsDetails(details:  _filteredMedicineList[index],)
                                  ,));
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
                          _filteredMedicineList[index]['parts_image'][0],
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
                              _filteredMedicineList[index]['part_name'],
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomButton(
                                text: 'Update',
                                color: Colors.amber,
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WorkShopUpdatePartsConfirmScreen(details: _filteredMedicineList[index],),));

                                 
                                 
                                },
                              ),
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
          ),
      ),
    )
;
  }
}

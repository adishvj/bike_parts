import 'dart:convert';
import 'dart:io';

import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/auth/workshop_reg.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class  ApiService{

   static  const  baseUrl =  'https://vadakara-mca-bike-backend.onrender.com';


  Future<void> userRegistration({required BuildContext context,required String name,required String phone,required String email,required  String  password,required String address}) async {
  try {
    var url = Uri.parse('$baseUrl/api/register/user');
    var response = await http.post(url, body: {
      'name': name,
      'email':  email,
      'mobile': phone,
      'address': address,
      'password': password
    });

    

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Success'),
      
    ));
     Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LoginScreen(),), 
    (route) => false);
    } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)['Message']),
    ));
    }
  } catch (e) {
    // Exception occurred
    print('Exception during registration: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error during registration: $e'),
    ));
  }
}







  Future<void> workShopRegistrations({required BuildContext context,required String name,required String phone,required String email,required  String  password,required String address}) async {
  try {
    var url = Uri.parse('$baseUrl/api/register/workshop');
    var response = await http.post(url, body: {
      'name': name,
      'email':  email,
      'mobile': phone,
      'address': address,
      'password': password
    });

  

    if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Success'),
      
    ));

     Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LoginScreen(),), 
    (route) => false);
    
    } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)['Message']),
    ));
    }
  } catch (e) {
    // Exception occurred
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error during registration: $e'),
    ));
  }
}

 



  Future<void> mechanicRegistration({required BuildContext context,required String name,required String phone,required String email,required  String  password,required String address,required String workshopId,required String qualification}) async {
  try {
    var url = Uri.parse('$baseUrl/api/register/mechanic');
    var response = await http.post(url, body: {
      'name': name,
      'email':  email,
      'mobile': phone,
      'address': address,
      'password': password,
      'workshop_id' :  workshopId,
      'qualification': qualification
    });

  

    if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Success'),
      
    ));

    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LoginScreen(),), 
    (route) => false);
    
    
    
    } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(jsonDecode(response.body)['Message']),
    ));
    }
  } catch (e) {
    // Exception occurred
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error during registration: $e'),
    ));
  }
}






Future<int> loginUser({required String email,required String password,required BuildContext context}) async {
  var url = Uri.parse('$baseUrl/api/login');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'email': email,
      'password': password,
    },
  );

  

   

  if (response.statusCode == 200) {

   var data = jsonDecode(response.body);

 
    if(data['success'] ==  true){

      DbService.setLoginId(data['loginId']);

      if(data['userRole'] == 2){
         DbService.setWorkShopId(data['workshopId']);

      }



      

    }



  

    // Handle successful response
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful'),
      ),
    );
    return jsonDecode(response.body)['userRole']??0;
  } else {
    // Handle error response
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login failed'),
      ),
    );
    return 0;
  }
}

//add  parts
Future<void> addParts(
      BuildContext context,

      String partname,
      String quantity,
      String price,
      String description,
      File image) async {
    // Show loading snack bar
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text('Adding used TV...'),
            ],
          ),
        ),
      );
    }

    final url = Uri.parse('$baseUrl/api/user/add-used-tv');

    print(url);

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add fields to the request
    request.fields['part_name'] = partname;
    request.fields['rate'] = price;
    request.fields['quantity'] = quantity;
    request.fields['login_id'] = DbService.getLoginId()!;
    request.fields['workshop_id'] = DbService.getWorkshopId()!;
    request.fields['description'] = description;

    print('image');

    var imageFile = await http.MultipartFile.fromPath('image', image.path);

    request.files.add(imageFile);

    try {
      var response = await request.send();

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('successfull'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to add used TV. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }


 




//add  parts
Future<void> updateParts(
     {
      
      required BuildContext context,

      String ? partname,
      String ? quantity,
      String ? price,
      String ? description,
      File ? image}
      
      ) async {
    // Show loading snack bar
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text('Adding used TV...'),
            ],
          ),
        ),
      );
    }

    final url = Uri.parse('$baseUrl/api/user/add-used-tv');

    print(url);

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add fields to the request
    request.fields['part_name'] = partname!;
    request.fields['rate'] = price!;
    request.fields['quantity'] = quantity!;
    request.fields['login_id'] = DbService.getLoginId()!;
    request.fields['workshop_id'] = DbService.getWorkshopId()!;
    request.fields['description'] = description!;

    print('image');
    if(image != null){


    var imageFile = await http.MultipartFile.fromPath('image', image.path);

    request.files.add(imageFile);
    }

    try {
      var response = await request.send();

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('successfull'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to add used TV. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }


  //add to cart

 

Future<void> addPartsToCart({required String loginId,required String partId,required  String price,required BuildContext context}) async {
  final url = Uri.parse('$baseUrl/api/user/add-parts-to-cart/$loginId/$partId');
  
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "price": price.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message']),
        ),
      );
    } else {
      throw Exception('Failed to add parts to cart');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }
}


Future<void> deleteCart(BuildContext context, String id) async {
  final url = Uri.parse('$baseUrl/api/user/delete-cart/$id');
  
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cart deleted successfully'),
        ),
      );
    } else {
      throw Exception('Failed to delete cart');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }
}

Future<void> orderParts(BuildContext context, String loginId) async {
  final url = Uri.parse('$baseUrl/api/user/order-parts/$loginId');
  
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Parts ordered successfully'),
        ),
      );
    } else {
      throw Exception('Failed to order parts');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }
}

























}//close
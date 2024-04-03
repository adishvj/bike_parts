import 'dart:convert';

import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/auth/workshop_reg.dart';
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

  print(response.body);

   

  if (response.statusCode == 200) {
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


 






}//close
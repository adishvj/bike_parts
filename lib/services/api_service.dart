import 'dart:convert';
import 'dart:io';

import 'package:bike_parts/modules/auth/login_screen.dart';
import 'package:bike_parts/modules/user/user_root_screen.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://vadakara-mca-bike-backend.onrender.com';

  Future<void> userRegistration(
      {required BuildContext context,
      required String name,
      required String phone,
      required String email,
      required String password,
      required String address}) async {
    try {
      var url = Uri.parse('$baseUrl/api/register/user');
      var response = await http.post(url, body: {
        'name': name,
        'email': email,
        'mobile': phone,
        'address': address,
        'password': password
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success'),
        ));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
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

  Future<void> workShopRegistrations(
      {required BuildContext context,
      required String name,
      required String phone,
      required String email,
      required String password,
      required String address}) async {
    try {
      var url = Uri.parse('$baseUrl/api/register/workshop');
      var response = await http.post(url, body: {
        'name': name,
        'email': email,
        'mobile': phone,
        'address': address,
        'password': password
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success'),
        ));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
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

  Future<void> mechanicRegistration(
      {required BuildContext context,
      required String name,
      required String phone,
      required String email,
      required String password,
      required String address,
      required String workshopId,
      required String qualification}) async {
    try {
      var url = Uri.parse('$baseUrl/api/register/mechanic');
      var response = await http.post(url, body: {
        'name': name,
        'email': email,
        'mobile': phone,
        'address': address,
        'password': password,
        'workshop_id': workshopId,
        'qualification': qualification
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success'),
        ));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
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

  Future<int> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
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

      if (data['success'] == true) {
        DbService.setLoginId(data['loginId']);

        if (data['userRole'] == 2) {
          DbService.setWorkShopId(data['workshopId']);
        }
      }

      // Handle successful response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
        ),
      );
      return jsonDecode(response.body)['userRole'] ?? 0;
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
      {required BuildContext context,
      required String partname,
      required String quantity,
      required String price,
      required String description,
      required File image}) async {
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

    final url = Uri.parse('$baseUrl/api/mechanic/add-parts');

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

    var imageFile = await http.MultipartFile.fromPath('image', image.path);

    request.files.add(imageFile);

    try {
      var response = await request.send();

      final responseData = await response.stream.bytesToString();
      // final parsedData = json.decode(responseData);

      print(responseData);

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
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
      {required BuildContext context,
      required String partsId,
      String? partname,
      String? quantity,
      String? price,
      String? description,
      File? image}) async {
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

    final url = Uri.parse('$baseUrl/api/mechanic/update-parts/$partsId');

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
    if (image != null) {
      var imageFile = await http.MultipartFile.fromPath('image', image.path);

      request.files.add(imageFile);
    }

    try {
      var response = await request.send();

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('successfull'),
          ),
        );

        Navigator.pop(context);
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

  Future<void> addPartsToCart(
      {required String loginId,
      required String partId,
      required String price,
      required BuildContext context}) async {
    final url =
        Uri.parse('$baseUrl/api/user/add-parts-to-cart/$loginId/$partId');

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
        print(response.body);
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

  Future<void> updateCartQuantity(
      {required BuildContext context,
      required String loginId,
      required String partsId,
      required int quantity,
      required String price}) async {
    String url = '$baseUrl/api/user/update-cart-quantity/$loginId/$partsId';

    Map<String, dynamic> body = {
      'quantity': quantity.toString(),
    };

    try {
      var response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cart quantity updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to update cart quantity. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating cart quantity: $e'),
        ),
      );
    }
  }

  Future<void> bookBike(
      {required BuildContext context, required Map data}) async {
    String apiUrl = '$baseUrl/api/user/book-bike/${DbService.getLoginId()}';

    Map<String, dynamic> postData = {
      'bike_name': data['bike_name'],
      'rate_per_day': data['rate_per_day'],
      'milage': data['milage'],
      'quantity': data['quantity'],
      'description': data['description'],
      'image': data['bike_image'][0],
    };

    try {
      final response = await http.post(Uri.parse(apiUrl), body: postData);

      print(response.body);

      if (response.statusCode == 200) {
        // Successful POST request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bike booked successfully!'),
          ),
        );

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 50,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text('Confirmed'),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'Confirm',
                  color: Colors.amber,
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserRootScreen()),
                    );
                  },
                )
              ],
            ),
          ),
        );
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to book bike. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> updateMechanicProfile(
      {required BuildContext context,
      required String loginId,
      required String name,
      required String phone,
      required String qualification}) async {
    final url =
        Uri.parse('$baseUrl/api/mechanic/update-mechanic-profile/$loginId');

    try {
      final response = await http.post(url, body: {
        'name': name,
        'mobile': phone,
        'qualification': qualification
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success'),
          ),
        );
      } else {
        throw Exception(
            'Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> approveMechanic(BuildContext context, String loginId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/register/approve-mechanic/$loginId'),
      );

      if (response.statusCode == 200) {
        // Request was successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Mechanic approved successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to approve mechanic: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // An error occurred
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> rejectMechanic(BuildContext context, String loginId) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}m/api/register/reject-mechanic/$loginId'),
      );

      if (response.statusCode == 200) {
        // Request was successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Mechanic rejected successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to reject mechanic: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // An error occurred
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> deleteBike(BuildContext context, String bikeId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/workshop/delete-bike/$bikeId'),
      );

      if (response.statusCode == 200) {
        // Request was successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Bike deleted successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to delete bike: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // An error occurred
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }
} //close

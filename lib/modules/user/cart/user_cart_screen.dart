import 'dart:convert';

import 'package:bike_parts/modules/user/checkout/check_out_screen.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserCartScreen extends StatefulWidget {
  const UserCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserCartScreen> createState() => _UserCartScreenState();
}

class _UserCartScreenState extends State<UserCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _fetchCart(DbService.getLoginId()!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No data'));
          } else {
            List<dynamic> cartItems = snapshot.data!['data'] as List<dynamic>;

           
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) => Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(),
                      ),
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Image.network(
                            cartItems[index]['parts_image'][0],
                            width: 100,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              cartItems[index]['part_name'],
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await ApiService().updateCartQuantity(
                                  context: context,
                                  loginId: DbService.getLoginId()!,
                                  partsId: cartItems[index]['parts_id'],
                                  quantity:
                                      cartItems[index]['quantity']+
                                          1,
                                  price: cartItems[index]['rate'].toString());

                              setState(() {});
                            },
                            child: const Text("+"),
                          ),
                          Text(
                            cartItems[index]['quantity'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await ApiService().updateCartQuantity(
                                  context: context,
                                  loginId: DbService.getLoginId()!,
                                  partsId: cartItems[index]['_id'],
                                  quantity:
                                      cartItems[index]['quantity'] -
                                          1,
                                  price: cartItems[index]['rate']);

                              setState(() {});
                            },
                            child: const Text("-"),
                          ),
                          GestureDetector(
                            onTap: () async {
                              setState(() {});

                              await ApiService()
                                  .deleteCart(context, cartItems[index]['_id']);

                              setState(() {});
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "₹ ${snapshot.data!['totalAmount']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckOut(
                            totalAmount:
                                snapshot.data!['totalAmount'].toString(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Check Out'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchCart(String loginId) async {
    final url = Uri.parse('${ApiService.baseUrl}/api/user/view-cart/$loginId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cart');
    }
  }
}

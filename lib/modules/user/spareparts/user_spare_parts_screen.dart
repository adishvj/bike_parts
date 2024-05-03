import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../services/api_service.dart';

class UserSparePartsScreen extends StatefulWidget {
  const UserSparePartsScreen({Key? key}) : super(key: key);

  @override
  State<UserSparePartsScreen> createState() => _UserSparePartsScreenState();
}

class _UserSparePartsScreenState extends State<UserSparePartsScreen> {
  final _searchController = TextEditingController();
  List<dynamic> _filteredPartsList = [];
  List<dynamic> _partsList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchPartsList();
  }

  Future<void> _fetchPartsList() async {
    setState(() {
      _loading = true;
    });
    final response = await http
        .get(Uri.parse('${ApiService.baseUrl}/api/user/view-all-parts'));
    if (response.statusCode == 200) {
      _partsList = jsonDecode(response.body)['data'];
      _filteredPartsList = _partsList;
    } else {
      throw Exception('Failed to load parts list');
    }
    setState(() {
      _loading = false;
    });
  }

  void _filterPartsList(String query) {
    setState(() {
      _filteredPartsList = _partsList
          .where((part) =>
              part['part_name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterPartsList,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: .55,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      children: _filteredPartsList.map((part) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            width: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        part['parts_image'][0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        part['part_name'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '₹${part['rate']}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    // Add to cart logic
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: const Color(0xffF7C910),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'ADD TO CART',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

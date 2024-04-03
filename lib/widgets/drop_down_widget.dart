
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Workshop {
  final String id;
  final String name;
  final String address;
  final String mobile;

  Workshop({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['_id'],
      name: json['workshop_name'] ?? '',
      address: json['address'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }
}

class WorkshopDropdown extends StatefulWidget {
  @override
  _WorkshopDropdownState createState() => _WorkshopDropdownState();
}

class _WorkshopDropdownState extends State<WorkshopDropdown> {
  List<Workshop> workshops = [];
  Workshop? selectedWorkshop;

  @override
  void initState() {
    super.initState();
    fetchWorkshops();
  }

  Future<void> fetchWorkshops() async {
    var url = Uri.parse('https://vadakara-mca-bike-backend.onrender.com/api/register/view-all-workshops');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      setState(() {
        workshops = data.map((workshop) => Workshop.fromJson(workshop)).toList();
      });
    } else {
      throw Exception('Failed to load workshops');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Workshop>(
      value: selectedWorkshop,
      onChanged: (Workshop? newValue) {
        setState(() {
          selectedWorkshop = newValue;
        });
      },
      items: workshops.map<DropdownMenuItem<Workshop>>((Workshop workshop) {
        return DropdownMenuItem<Workshop>(
          value: workshop,
          child: Text(workshop.name),
        );
      }).toList(),
    );
  }
}
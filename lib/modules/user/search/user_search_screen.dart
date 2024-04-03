import 'package:flutter/material.dart';

class UserSearchScreen extends StatelessWidget {
   UserSearchScreen({super.key});


  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text('User Search'),),

        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 55,
              child: TextField(
                enabled: true,
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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

            const Expanded(child: Column())
          ],
        ),
      
    );
  }
}
import 'package:bike_parts/modules/user/workshop/user_bike_details.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RentBikesView extends StatefulWidget {
  const RentBikesView({super.key});

  @override
  State<RentBikesView> createState() => _RentBikesViewState();
}

class _RentBikesViewState extends State<RentBikesView> {
  final List<String> items =
      List<String>.generate(10, (index) => "Item $index");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.carandbike.com/bike-images/big/ktm/rc-200/ktm-rc-200.jpg?v=26'),
            ),
            title: Center(
              child: Text(items[index]),
            ),
            trailing: CustomButton(
              text: 'View',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserBikeScreen(
                      image: '',
                    ),
                  ),
                );
              },
            ), // CustomButton widget goes here
          );
        },
      ),
    );
  }
}

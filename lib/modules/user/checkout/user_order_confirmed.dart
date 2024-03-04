import 'package:bike_parts/modules/user/user_root_screen.dart';
import 'package:bike_parts/utils/constants.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({super.key});

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 20,
    );
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.check_circle,
            size: 100,
            color: Colors.white,
          ),
          sizedBox,
          const Text(
            'Your order has been received',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Order status',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          sizedBox,
          SizedBox(
            width: 200,
            child: CustomButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserRootScreen(),
                  ),
                  (route) => false,
                );
              },
              text: 'Home',
              color: Colors.white,
              texColor: Colors.black,
            ),
          )
        ]),
      ),
    );
  }
}

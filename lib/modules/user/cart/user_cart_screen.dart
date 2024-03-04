import 'package:bike_parts/modules/user/checkout/check_out_screen.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserCartScreen extends StatefulWidget {
  const UserCartScreen({super.key});

  @override
  State<UserCartScreen> createState() => _UserCartScreenState();
}

class _UserCartScreenState extends State<UserCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all()),
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      const Image(
                        image: NetworkImage(
                          "https://images.carandbike.com/bike-images/big/ktm/rc-200/ktm-rc-200.jpg?v=26",
                        ),
                        width: 100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "150cc Exhaust",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(onPressed: () {}, child: const Text("+")),
                      const Text(
                        "1",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(onPressed: () {}, child: const Text("-")),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    "₹100",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              child: CustomButton(
                color: Colors.amber,
                text: 'Check Out',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckOut(),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

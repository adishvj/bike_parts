import 'package:bike_parts/modules/user/checkout/user_order_confirmed.dart';
import 'package:bike_parts/utils/constants.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('CheckOut',
            style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold')),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
              child: ListView(children: [
            Container(
              margin:
                  const EdgeInsets.only(top: 50, bottom: 4, left: 4, right: 4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.grey.shade200)),
                  padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        'Address:',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade800),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _addressController,
                        hintText: 'Enter Address',
                        borderColor: Colors.grey,
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Mobile : ",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade800)),
                          const TextSpan(
                              text: "02222673745",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      // standard Delivery

                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Colors.tealAccent.withOpacity(0.4),
                                width: 1),
                            color: Colors.tealAccent.withOpacity(0.2)),
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: 1,
                              onChanged: (isChecked) {},
                              activeColor: Colors.tealAccent.shade400,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Standard Delivery",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Get it by 20 jul - 27 jul | Free Delivery",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      // price section

                      Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Card(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                border:
                                    Border.all(color: Colors.grey.shade200)),
                            padding: const EdgeInsets.only(
                                left: 12, top: 8, right: 12, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  "PRICE DETAILS",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total MRP",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '5197',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Bag discount",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '3280',
                                        style: TextStyle(
                                            color: Colors.teal.shade300,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Tax",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '96',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Order Total",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '2013',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Delievery Charges",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'FREE',
                                        style: TextStyle(
                                            color: Colors.teal.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '2013',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 120,
                                ),

                                //button

                                Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    child: CustomButton(
                                      text: 'Place Order',
                                      color: Colors.amber,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OrderConfirmScreen(),
                                          ),
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]))
        ]),
      ),
    );
  }
}

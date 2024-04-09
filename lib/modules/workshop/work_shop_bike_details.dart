import 'package:bike_parts/modules/user/user_root_screen.dart';
import 'package:bike_parts/modules/workshop/work_shop_bike_update_confirmation.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WorkShopBikeScreen extends StatefulWidget {
  const WorkShopBikeScreen(
      {super.key, required this.image, required this.details});

  final String image;
  final Map<String, dynamic> details;

  @override
  State<WorkShopBikeScreen> createState() => _WorkShopBikeScreenState();
}

class _WorkShopBikeScreenState extends State<WorkShopBikeScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      height: 2,
      color: Colors.grey,
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                child: Image(
              image: NetworkImage(widget.image),
              fit: BoxFit.fill,
            )),
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.details['description'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Spacification',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          divider,
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Milage:${widget.details['milage']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Spacer(),
                              Text(
                                '₹${widget.details['rate_per_day']}/day',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      CustomButton(
                                        text: 'Update',
                                        color: Colors.amber,
                                        onPressed: () async {
                                          setState(() {
                                            loading = false;
                                          });

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WorkShopUpdatePartsConfirmScreen(
                                                  details: widget.details,
                                                ),
                                              ));

                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                      ),
                                      CustomButton(
                                        text: 'Delete',
                                        color: Colors.amber,
                                        onPressed: () async {
                                          setState(() {
                                            loading = false;
                                          });

                                          await ApiService().deleteBike(
                                              context, widget.details['_id']);

                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}

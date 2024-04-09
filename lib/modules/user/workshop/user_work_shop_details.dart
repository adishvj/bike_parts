import 'package:bike_parts/modules/user/workshop/user_rent_bike_view.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserWorkShopDetails extends StatelessWidget {
  const UserWorkShopDetails({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    print(details);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                child: Image(
              image: NetworkImage(
                'https://img.freepik.com/free-photo/mechanic-repairing-bicycle_23-2148138617.jpg?w=1380&t=st=1708497923~exp=1708498523~hmac=db0aa97cb4ebd6cb6b1a4e4f5a8da5d25d20e4a8be9b4bb5abeb10a7cbbcc7d0',
              ),
              fit: BoxFit.fill,
            )),
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            details['workshop_name'] ?? 'workshop',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            details['mobile'] ?? '123456789',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            details['address'] ?? 'address',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'Rent  bike',
                              color: Colors.amber,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RentBikesView(),
                                  ),
                                );
                              },
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

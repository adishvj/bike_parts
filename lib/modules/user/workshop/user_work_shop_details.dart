import 'package:bike_parts/modules/user/workshop/user_rent_bike_view.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserWorkShopDetails extends StatelessWidget {
  const UserWorkShopDetails({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                child: Image(
              image: NetworkImage(image),
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
                            'Description',
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
                          Expanded(
                            child: Text(
                              'A bike workshop is a place where bicycles are repaired, serviced, and customized. It is often run by experienced mechanics who are knowledgeable about different types of bikes and their components. Bike workshops typically offer services such as tune-ups, brake adjustments, tire repairs, and part replacements. They may also sell bike accessories, parts, and sometimes new or used bikes. Bike workshops are essential for maintaining the performance and safety of bicycles, and they play a crucial role in supporting cycling communities and promoting sustainable transportation.',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 20,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade500),
                            ),
                          ),
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

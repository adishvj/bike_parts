import 'package:bike_parts/modules/user/workshop/user_rent_bike_view.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserWorkShopDetails extends StatelessWidget {
  const UserWorkShopDetails({super.key, required this.image,required this.details});

  final String image;
  final Map<String,dynamic>  details;

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

                              details['workshop_name']??'workshop',
                              
                              overflow: TextOverflow.ellipsis,
                              maxLines:4,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade500),
                            ),
                          SizedBox(height: 20,),

                          

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

                              details['mobile']??'123456789',
                              
                              overflow: TextOverflow.ellipsis,
                              maxLines:4,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade500),
                            ),
                          SizedBox(height: 20,),
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

                              details['address']??'address',
                              
                              overflow: TextOverflow.ellipsis,
                              maxLines:4,
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

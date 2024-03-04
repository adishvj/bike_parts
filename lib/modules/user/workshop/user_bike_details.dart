import 'package:bike_parts/modules/user/user_root_screen.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserBikeScreen extends StatelessWidget {
  const UserBikeScreen({super.key, required this.image});

  final String image;

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
            const Expanded(
                child: Image(
              image: NetworkImage('https://images.carandbike.com/bike-images/big/ktm/rc-200/ktm-rc-200.jpg?v=26'),
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
                            'A bike workshop is a place where bicycles are repaired, serviced, and customized. It is often run by experienced mechanics who are knowledgeable about different types of bikes and their components. Bike workshops typically offer services such as tune-ups, brake adjustments, tire repairs, and part replacements. They may also sell bike accessories, parts, and sometimes new or used bikes. Bike workshops are essential for maintaining the performance and safety of bicycles, and they play a crucial role in supporting cycling communities and promoting sustainable transportation.',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                          const SizedBox(height: 10,),
                          const Text(
                            'Spacification',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          divider,

                          const SizedBox(height: 10,),
                          Text(
                            'helmet',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                            const SizedBox(height: 10,),

                          Text(
                            '1 L',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),


                          const Spacer(),
                          const Row(
                            children: [

                              Text('Price',style: TextStyle(color: Colors.black,fontSize: 20),),
                              Spacer(),
                              Text('₹100/day',style: TextStyle(color: Colors.black,fontSize: 20),),


                          ],),
                          const SizedBox(height: 10,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'Book now',
                              color: Colors.amber,
                              onPressed: () {

                                showDialog(context: context, builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check_circle,size: 50,),
                                      const SizedBox(height: 30,),
                                      const Text('Confirmed'),
                                      const SizedBox(height: 30,),
                                      CustomButton(
                                        text: 'Confirm', 
                                        color: Colors.amber,
                                        onPressed: (){
                                          Navigator.pushReplacement(
                                            context, 
                                            MaterialPageRoute(builder: (context) => const UserRootScreen()),);
                                        },

                                        )
                                      
                                    ],
                                  ),
                                )
                                ,);
                                
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

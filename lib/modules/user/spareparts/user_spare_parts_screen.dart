import 'package:bike_parts/modules/user/cart/user_cart_screen.dart';
import 'package:flutter/material.dart';


class UserSparePartsScreen extends StatefulWidget {
  const UserSparePartsScreen({super.key});

  @override
  State<UserSparePartsScreen> createState() => _UserSparePartsScreenState();
}

class _UserSparePartsScreenState extends State<UserSparePartsScreen> {
  final _searchController = TextEditingController();

   final partList = [
    'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'
     ,'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'

       ,'https://w7.pngwing.com/pngs/470/228/png-transparent-spare-part-motorcycle-engine-machine-engine-motorcycle-vehicle-transport-thumbnail.png'

  
  ];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
          children: [
             SizedBox(height: 30,),
             Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 55,
              child: TextField(
                enabled: true,
                controller: _searchController,
                decoration: InputDecoration(
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
            const SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    childAspectRatio: .55,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    children: List.generate(
                      partList.length,
                      (index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
              width: 160,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          
                          partList[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Engin parts',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 10,),
    
                        Text(
                          '170 OMA',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 10,),
                        
    
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserCartScreen(),),);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color:  const Color(0xffF7C910),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: const Text(
                            'ADD TO CART',
                            style:  TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                          ),
                            
                    ),
                  ),
    
                  
                ],
              ),
            ),
          
                      ),
                    )),
              ),
            )
          ],
        ),
    );
  }
}
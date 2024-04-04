import 'package:flutter/material.dart';


class MechanicPartsDetails extends StatefulWidget {
  const MechanicPartsDetails({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  State<MechanicPartsDetails> createState() => _MechanicPartsDetailsState();
}

class _MechanicPartsDetailsState extends State<MechanicPartsDetails> {
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 10,
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: Column(
          children: [

            SizedBox(height: 30,),
            Expanded(
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.details['parts_image'][0],
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                     Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ColumnText(
                                  text1: 'Name',
                                  text2: widget.details['part_name']
                                ),
                                
                               
                                sizedBox,
                                ColumnText(
                                    text1: 'Description',
                                    text2: widget.details['description']
                                        
                                        ),
                               
                                    sizedBox,
                                ColumnText(
                                    text1: 'Quantity',
                                    text2: widget.details['quantity'],
                                        ),

                              ColumnText(
                                    text1: 'Price',
                                    text2: widget.details['rate'].toString(),
                                        ),
                              ],
                            ),
                          ),
                        ))
                 
                 
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  
  
  
  }
}




class ColumnText extends StatelessWidget {
  const ColumnText({super.key, required this.text1, required this.text2});

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700
          ),
        ),
        Divider(
          endIndent: 10,
          thickness: .7,
          color: Colors.grey.shade400,
        ),
        Text(
          text2,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
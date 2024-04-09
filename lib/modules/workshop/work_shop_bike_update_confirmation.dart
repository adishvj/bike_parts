import 'dart:io';

import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/services/db_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WorkShopUpdatePartsConfirmScreen extends StatefulWidget {
  WorkShopUpdatePartsConfirmScreen({super.key, required this.details});


  final Map<String,dynamic> details;

  @override
  State<WorkShopUpdatePartsConfirmScreen> createState() => _WorkShopUpdatePartsConfirmScreenState();
}

class _WorkShopUpdatePartsConfirmScreenState extends State<WorkShopUpdatePartsConfirmScreen> {
  
  final _bikeNameController = TextEditingController();
  final _rate_per_day = TextEditingController();
  final _qtyController = TextEditingController();
  final _milageController =  TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _bikeNameController.text = widget.details['bike_name'];
    _rate_per_day.text = widget.details['rate_per_day'];
    _milageController.text = widget.details['milage'];
    _qtyController.text = widget.details['quantity'];
    _descriptionController.text =widget.details['description'];



    super.initState();
  }


 

  bool loading = false;

  String type = '';

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
  }

  void _getFromgallary() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "Update Bike",
              style: TextStyle(fontSize: 25),
            ),
            Icon(Icons.tv_sharp)
          ],
        ),
        toolbarHeight: 100,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        fixedSize: const Size(150, 50)),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                50)),
                                                    onPressed: () {
                                                      _getFromCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons
                                                            .camera_alt_outlined),
                                                        Text("Take a photo")
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                50)),
                                                    onPressed: () {
                                                      _getFromgallary();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(CupertinoIcons
                                                            .photo_on_rectangle),
                                                        Text(
                                                            "Upload from gallary")
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Add photo")),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: image == null
                                            ? const Text("upload image")
                                            : Image(
                                                image: FileImage(
                                                    File(image!.path))),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.eye,
                                    size: 30,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Name",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                              borderColor: Colors.white,
                              controller: _bikeNameController,
                              hintText: "Enter bike name"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Quantity",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                              borderColor: Colors.white,
                              controller: _qtyController,
                              hintText: "Enter quantity"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Milage",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                            borderColor: Colors.white,
                            controller: _milageController,
                            hintText: "Enter milage ",
                          ),

                          const Text(
                            "Rate per day",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                            borderColor: Colors.white,
                            controller: _rate_per_day,
                            hintText: "Enter rent",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _descriptionController,
                            minLines: 6,
                            maxLines: 200,
                            decoration: const InputDecoration(
                                hintText: "Add Description....",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: CupertinoColors.inactiveGray)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CupertinoColors.activeBlue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: "Submit",
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });

                               
                                  await ApiService().updateBikeInWorkshop(
                                    context: context,
                                    id: widget.details['_id'],
                                    bikeName: _bikeNameController.text,
                                    ratePerDay: double.parse(_rate_per_day.text),
                                    milage: double.parse(_milageController.text),
                                    quantity: int.parse(_qtyController.text),
                                    description: _descriptionController.text,
                                    imagePath: image != null ? image!.path : null

                                    );
                               

                                setState(() {
                                  loading = false;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
    );
  }
}

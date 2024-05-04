import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class UserBikeScreen extends StatefulWidget {
  const UserBikeScreen({super.key, required this.image, required this.details});

  final String image;
  final Map<String, dynamic> details;

  @override
  State<UserBikeScreen> createState() => _UserBikeScreenState();
}

class _UserBikeScreenState extends State<UserBikeScreen> {
  bool loading = false;
  final quantity_controller = TextEditingController();
  DateTime _selectedValue = DateTime.now();
  DateTime _dropofdate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                            const Text(
                              'pick up date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            DatePicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              height: 100,
                              onDateChange: (date) {
                                // New date selected
                                setState(() {
                                  _selectedValue = date;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Time',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final TimeOfDay? picked =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (picked != null &&
                                        picked != _selectedTime) {
                                      setState(() {
                                        _selectedTime = picked;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '${_selectedTime.format(context)}',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Drop of date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            DatePicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              height: 100,
                              onDateChange: (date) {
                                // New date selected
                                setState(() {
                                  _dropofdate = date;
                                });
                              },
                            ),
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
                                    child: CustomButton(
                                      text: 'Book now',
                                      color: Colors.amber,
                                      onPressed: () async {
                                        setState(() {
                                          loading = false;
                                        });

                                        await ApiService().bookBike(
                                          context: context,
                                          data: widget.details,
                                          bike_quantity:
                                              quantity_controller.text,
                                          dropoff_date:
                                              "${_dropofdate.day}/${_dropofdate.month}/${_dropofdate.year}",
                                          pickup_date:
                                              "${_selectedValue.day}/${_selectedValue.month}/${_selectedValue.year}",
                                          pickup_time:
                                              "${_selectedTime.hour}:${_selectedTime.minute}",
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
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}

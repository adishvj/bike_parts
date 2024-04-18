import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserEditProfileScreen extends StatelessWidget {
  UserEditProfileScreen(
      {super.key,
      required this.name,
      required this.phone,
      required this.address});

  final String name;
  final String phone;
  final String address;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.text = address;
    _phoneController.text = phone;
    _nameController.text = name;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'name',
                controller: _nameController,
                borderColor: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'email',
                controller: _emailController,
                borderColor: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'phone',
                controller: _phoneController,
                borderColor: Colors.grey.shade500,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: 'Confirm',
                color: Colors.amber,
                onPressed: () {
                  
                  Navigator.pop(context, true);
                },

              ),
            )
          ],
        ),
      ),
    );
  }
}

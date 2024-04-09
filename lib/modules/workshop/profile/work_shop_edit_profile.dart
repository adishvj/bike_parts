import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class WorkShopEditProfileScreen extends StatefulWidget {
  WorkShopEditProfileScreen({
    super.key, 
    required this.name, 
    required this.phone, 
    required this.address
    });

  final String  name;
  final String phone;
  final String address;

  @override
  State<WorkShopEditProfileScreen> createState() => _WorkShopEditProfileScreenState();
}

class _WorkShopEditProfileScreenState extends State<WorkShopEditProfileScreen> {
TextEditingController _nameController = TextEditingController();

TextEditingController _emailController = TextEditingController();

TextEditingController _phoneController = TextEditingController();

bool loading =  false;

@override
  void initState() {
    
    _emailController.text = widget.address;
    _phoneController.text = widget.phone;
    _nameController.text =  widget.name;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: loading ? Center(child: CircularProgressIndicator(),)  : SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
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


                  setState(() {
                    loading = true;
                  });

                  ApiService().updateWorkshopProfile(
                    workshopName: _nameController.text, 
                    mobile: _emailController.text, address: _phoneController.text, context: context);

                  setState(() {
                    loading = false;
                  });


                

                

                


                 
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

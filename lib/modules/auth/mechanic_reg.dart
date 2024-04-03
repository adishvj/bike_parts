import 'dart:convert';

import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/utils/validator.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Workshop {
  final String id;
  final String name;
  final String address;
  final String mobile;

  Workshop({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['_id'],
      name: json['workshop_name'] ?? '',
      address: json['address'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }
}

class MechanicRegistration extends StatefulWidget {
  const MechanicRegistration({super.key});

  @override
  State<MechanicRegistration> createState() => _MechanicRegistrationState();
}

class _MechanicRegistrationState extends State<MechanicRegistration> {
  String? emailError;
  String? passwordError;

  bool _obscureText = true;

  final _nameControllers = TextEditingController();
  final _phoneControllers = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _qualificationController =  TextEditingController();

  bool loading = false;

  List<Workshop> workshops = [];
  Workshop? selectedWorkshop;

  Future<void> fetchWorkshops() async {
    var url =
        Uri.parse('${ApiService.baseUrl}/api/register/view-all-workshops');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      setState(() {
        workshops =
            data.map((workshop) => Workshop.fromJson(workshop)).toList();
      });
    } else {
      throw Exception('Failed to load workshops');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorkshops();
  }

  @override
  void dispose() {
    _nameControllers.dispose();
    _phoneControllers.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SignUp',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    CustomTextField(
                      hintText: 'Enter name',
                      controller: _nameControllers,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Enter phone',
                      controller: _phoneControllers,
                      input: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Enter email',
                      controller: _emailController,
                      errorText: emailError,
                      input: TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Enter address',
                      controller: _addressController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Enter qualification',
                      controller: _qualificationController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: double.infinity,
                      child: DropdownButton<Workshop>(
                        value: selectedWorkshop,
                        isExpanded: true,
                        onChanged: (Workshop? newValue) {
                          setState(() {
                            selectedWorkshop = newValue;
                          });
                        },
                        items: workshops.map<DropdownMenuItem<Workshop>>(
                            (Workshop workshop) {
                          return DropdownMenuItem<Workshop>(
                            
                            value: workshop,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(workshop.name),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      hintText: 'Enter password',
                      controller: _passwordController,
                      errorText: passwordError,
                      obscureText: _obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Confirm password',
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: 'Sign up',
                        onPressed: () {
                          _signUpHandler(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  _signUpHandler(BuildContext context) async {
    emailError = validateEmail(_emailController.text);
    passwordError = validatePassword(_passwordController.text);

    setState(() {});
    if (emailError == null &&
        passwordError == null &&
        _nameControllers.text.isNotEmpty &&
        _phoneControllers.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _qualificationController.text.isNotEmpty&&
        selectedWorkshop != null
        ) {
      if (_passwordController.text == _confirmPasswordController.text) {
        setState(() {
          loading = true;
        });

        await ApiService().mechanicRegistration(
            context: context,
            name: _nameControllers.text,
            phone: _phoneControllers.text,
            email: _emailController.text,
            password: _confirmPasswordController.text,
            address: _addressController.text,
            qualification: _qualificationController.text,
            workshopId: selectedWorkshop!.id,
            
            
            );

        setState(() {
          loading = false;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Password not match')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
      setState(() {});
    }
  }
}

import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/utils/validator.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class WorkShopRegistrations extends StatefulWidget {
  const WorkShopRegistrations({super.key});

  @override
  State<WorkShopRegistrations> createState() => _WorkShopRegistrationsState();
}

class _WorkShopRegistrationsState extends State<WorkShopRegistrations> {
  String? emailError;
  String? passwordError;

  bool _obscureText = true;

  final _nameControllers = TextEditingController();
  final _phoneControllers = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();

  bool loading =  false;

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
      body: loading ?  const  Center(
        child: CircularProgressIndicator(),
      )  : SingleChildScrollView(
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
              const SizedBox(height: 30,),
              CustomTextField(
                hintText: 'Enter password',
                controller: _passwordController,
                errorText: passwordError,
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
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

  _signUpHandler(BuildContext context)  async{
   
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);

      setState(() {
        
      });
      if (emailError == null &&
          passwordError == null &&
          _nameControllers.text.isNotEmpty &&
          _phoneControllers.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        if (_passwordController.text == _confirmPasswordController.text) {


          setState(() {
            loading =  true;
          });


          await ApiService().workShopRegistrations(
            context: context, name: _nameControllers.text, 
            phone: _phoneControllers.text, 
            email: _emailController.text,
             password: _confirmPasswordController.text, 
             address: _addressController.text);
           setState(() {
            loading =  false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password not match')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All fields are required')));
        setState(() {});
      }
   
  }
}

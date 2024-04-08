import 'package:bike_parts/modules/auth/choose_registration_screen.dart';
import 'package:bike_parts/modules/auth/signup_screen.dart';
import 'package:bike_parts/modules/mechanic/mechanic_home.dart';
import 'package:bike_parts/modules/user/user_root_screen.dart';
import 'package:bike_parts/modules/workshop/workshop_home_screen.dart';
import 'package:bike_parts/services/api_service.dart';
import 'package:bike_parts/utils/validator.dart';
import 'package:bike_parts/widgets/custom_button.dart';
import 'package:bike_parts/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.white),
  );

  String? emailError;
  String? passwordError;

  bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7C910),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  CustomTextField(
                    hintText: 'Enter Email',
                    controller: _emailController,
                    errorText: emailError,
                  ),
                  const SizedBox(height: 30),
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
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'Forget password',
                  //       style: TextStyle(color: Colors.black),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                      text: 'Login',
                      onPressed: () {
                        _loginHandler();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChooseRegistrationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
    );
  }

  void _loginHandler() async {
    emailError = validateEmail(_emailController.text);
    passwordError = validatePassword(_passwordController.text);

    setState(() {});
    if (emailError == null && passwordError == null) {
      setState(() {
        loading = true;
      });

      int role = await ApiService().loginUser(
          email: _emailController.text,
          password: _passwordController.text,
          context: context);

          print(role);

      if (role == 3) {
        if(context.mounted){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserRootScreen(),
            ),
            (route) => false);
        }
      }

      if (role == 1) {

         if(context.mounted){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkShopHomeScreen(),
            ),
            (route) => false);
         }
      }

      if(role == 2){

        if(context.mounted){

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MechanicHomeScreen(),
            ),
            (route) => false);
        }


      }

      setState(() {
        loading = false;
      });

     
      
    } else {
      setState(() {});
    }
  }
}

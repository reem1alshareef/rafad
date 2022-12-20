// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:rafad1/widgets/my_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rafad1/widgets/custom_input_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController =TextEditingController();
  
  @override 
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
  
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 180,
              child: Image.asset('assets/images/logo.png'),
            ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter your Email and we will send you a password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),
        ),

        const SizedBox(height: 10,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Email' ,
              fillColor: Colors.grey[200],
              filled: true,
              ),
            ),
          ),

          const SizedBox(height: 10,),
          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email id',
                            isDense: true,
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if(!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }
                        ),
         MyButton(
              color: const Color(0xFF455D83),
              title: 'Reset Password',
              onPressed: passwordReset,
            )
      ],
      ),
    ),
    );
  }

 
}
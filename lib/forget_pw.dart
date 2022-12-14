// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();


  @override 
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {}
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter Your Email and we will send you a password reset link',
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
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Email' ,
              fillColor: Colors.grey[200],
              filled: true,
              ),
            ),
          ),

          const SizedBox(height: 10,),

          MaterialButton(
            onPressed: passwordReset,
            color: Colors.blue,
            child: const Text('Reset Password'),
            ),
      ],
      ),
    );
  }
}



